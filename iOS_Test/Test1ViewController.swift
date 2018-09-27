//
//  Test1ViewController.swift
//  Contact
//
//  Created by Mayur Susare on 26/09/18.
//  Copyright © 2018 Vivek Gajbe. All rights reserved.
//

import UIKit
import Contacts
import SystemConfiguration
import MessageUI

class Test1ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //MARK: - variable declaration
    var contactsList = [CNContact]()
    
    //let entContact: CNContact
    @IBOutlet weak var tblContact: UITableView!
    //var arrContactList : [entContact]
    
    //MARK: - init method
    override func viewDidLoad() {
        super.viewDidLoad()
   
        //for fetchching contact list from phone
        self.fetchContacts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - User define method
    private func fetchContacts() {
        print("Attempting to fetch contacts")
        
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err {
                print("Failed to request access:", err)
                return
            }
            
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do {
                    
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointerIfYouWantToStopEnumerating) in
                        //contacts provides all the details about your cell contact like name,phone number etc
                        self.contactsList.append(contact)
                        
                    })
                    DispatchQueue.main.async {
                        //reload table on main thread because above method is called in globale/Background thread
                        self.tblContact.reloadData()
                    }
                } catch let err {
                    print("Failed to enumerate contacts:", err)
                }
                
            } else {
                //print("Access denied..")
            }
        }
    }
    //MARK: - tableview delegate method

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return contactsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tblContact.dequeueReusableCell(withIdentifier: "cellContact") as! clsContactTableViewCell
        let contact = contactsList[indexPath.row]
        //Display contact details on the screen
        cell.lblName.text = contact.givenName
        cell.lblPhoneNumber.text = contact.phoneNumbers.first?.value.stringValue ?? ""
        cell.btnCall.addTarget(self, action: #selector(btnCallClicked(sender:)), for: .touchUpInside)
        cell.btnCall.tag = indexPath.row
        cell.btnSMS.addTarget(self, action: #selector(btnSMSClicked(sender:)), for: .touchUpInside)
        cell.btnSMS.tag = indexPath.row
        
        return cell
    }
    
    /// Method is used for CALL handling
    ///
    /// - Parameter sender: UIButton
    @objc func btnCallClicked(sender:UIButton) {
        let contact = contactsList[sender.tag]

        let strNumber = contact.phoneNumbers.first?.value.stringValue ?? ""
        guard let number = URL(string: "telprompt://" + strNumber) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(number, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(number as URL)
        }
    }
    /// Method is used for SMS handling
    ///
    /// - Parameter sender: UIButton
    @objc func btnSMSClicked(sender:UIButton) {
        let contact = contactsList[sender.tag]
        
        if MFMessageComposeViewController.canSendText() {
            let messageComposeVC = MFMessageComposeViewController()
            messageComposeVC.body = "Hi, This is a test message"
            messageComposeVC.recipients = [contact.phoneNumbers.first?.value.stringValue ?? ""]
            messageComposeVC.recipients = nil
            messageComposeVC.messageComposeDelegate = self as! MFMessageComposeViewControllerDelegate
            self.present(messageComposeVC, animated: true, completion: nil)
            //RMConstant.APP_DEL.window?.rootViewController?.present(messageComposeVC, animated: true, completion: nil)
        }
        else{
        Utility().ShowAlert(title : "" ,message:"SMS is not suppported by this application" ,onView:self)
        }
 
    }
    //MARK:- SMS delegate method
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        // Check the result or perform other tasks.
        // Dismiss the Message compose view controller.
        switch (result.rawValue) {
        case MessageComposeResult.cancelled.rawValue:
            controller.dismiss(animated: true, completion: nil)
            
        case MessageComposeResult.failed.rawValue:
            controller.dismiss(animated: true, completion: nil)
            
        case MessageComposeResult.sent.rawValue:
            controller.dismiss(animated: true, completion: nil)
            
        default:
            break;
        }
    }


}
