//
//  Test2ViewController.swift
//  Contact
//
//  Created by Mayur Susare on 26/09/18.
//  Copyright © 2018 Vivek Gajbe. All rights reserved.
//

import UIKit


class Test2ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate {
    //Variable declaration
    var arrCategoryDetails = [clsCategotyEntity]()
    var arrCategory = NSMutableArray()
    var arrSearchCategory = NSMutableArray()
    var searchActive : Bool = false
    @IBOutlet weak var SearchBarCategory: UISearchBar!
    @IBOutlet weak var tblCategory: UITableView!
    
    //MARK: - init method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDategoryDetails()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- button delegate method
    
    //MARK:- user define method
/// Method used to call category api details
func getDategoryDetails()
{
    let url = "https://bofindevstorage.blob.core.windows.net/categories/categories.json"
    
    URLSession.shared.dataTask(with: NSURL(string: url)! as URL) { data, response, error in
        // Handle result
        do {
            let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
            self.parseCategoryDetails(json : json)
        } catch {
            print("error")
        }
        }.resume()
    }
    
    /// parser method to call parsing Json Data and store it in array
    ///
    /// - Parameter json: <#json description#>
    func parseCategoryDetails(json : Dictionary<String, AnyObject>)
   {
    if let item_categories = json["item_categories"] as? [Any] {
        // treat it as an array.
        for item in item_categories
        {
             let itemDetails = item as! [String:Any]
            
            if let item_Details = itemDetails["items"] as? [Any] {
                var arrCat = [clsCategotyEntity]()
                for i in item_Details
                {
                    let entCategory = clsCategotyEntity()
                    if let strCategory = itemDetails["category"] as? String {
                        entCategory.strCategory = strCategory
                    }
                    
                    let details = i as! [String:Any]
                    //optional chaning for checking variable nil
                    if let id = details["id"] as? Int
                    {
                       entCategory.id = "\(id)"
                    }
                    if let inv_mast_uid = details["inv_mast_uid"] as? Int
                    {
                        entCategory.inv_mast_uid = inv_mast_uid
                    }
                    if let item_id = details["item_id"] as? String
                    {
                        entCategory.item_id = item_id
                    }
                    if let item_desc = details["item_desc"] as? String
                    {
                        entCategory.item_desc = item_desc
                    }
                    if let unit = details["unit"] as? String
                    {
                        entCategory.unit = unit
                    }
                    if let image = details["image"] as? String
                    {
                        entCategory.image = image
                    }
                    if let notes = details["notes"] as? String
                    {
                        entCategory.notes = notes
                    }
                    arrCat.append(entCategory)
                }
                self.arrCategory.add(arrCat)
                self.arrSearchCategory.add(arrCat)
            }
        }
    }
    DispatchQueue.main.async {
        //reload table on main thread because above method is called in globale/Background thread
        self.tblCategory.reloadData()
    }
    
    }
    //MARK: - tableview delegate method
    
    // number of rows in table view
    func numberOfSections(in tableView: UITableView) -> Int
    {
       return arrSearchCategory.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44)
        let viwHeader = UIView(frame:rect)
        viwHeader.backgroundColor = UIColor.clear
        let label = UILabel()
        let arr:[clsCategotyEntity] = arrSearchCategory.object(at: section) as! [clsCategotyEntity]
        if arr.count > 0
        {
            let entCategory = arr[0]
            label.text = entCategory.strCategory
            label.frame = CGRect(x: 10, y: 0, width: tableView.frame.size.width - 20, height: 44)
        }
        else{
            viwHeader.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0)
            label.frame = CGRect(x: 10, y: 0, width: tableView.frame.size.width - 20, height: 0)
        }
        
        
        
        viwHeader.addSubview(label)
        viwHeader.backgroundColor = .white
        return viwHeader
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let arr:[clsCategotyEntity] = arrSearchCategory.object(at: section) as! [clsCategotyEntity]
        if arr.count > 0
        {
            return 44
        }
        else{
            return 0
        }    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let arr : [clsCategotyEntity] = arrSearchCategory.object(at: section) as! [clsCategotyEntity]
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tblCategory.dequeueReusableCell(withIdentifier: "cellCategory") as! clsCategoryTableViewCell
        let arr:[clsCategotyEntity] = arrSearchCategory.object(at: indexPath.section) as! [clsCategotyEntity]
        let entCategory = arr[indexPath.row]
        cell.lblProductName.text = entCategory.item_desc
        cell.lblProductID.text = "\(String(describing: entCategory.id))"
        cell.lblTermId.text = entCategory.item_id!
        cell.lblUnit.text = entCategory.unit
        //cell.lblNote.text = entCategory.notes
        cell.imgProfile.imageFromServerURL(urlString: entCategory.image!)
        
        cell.viwBG.layer.shadowColor = UIColor.darkGray.cgColor
        cell.viwBG.layer.shadowOpacity = 1
        cell.viwBG.layer.masksToBounds = false
        cell.viwBG.layer.shadowRadius = 5
        cell.viwBG.layer.cornerRadius = 10
        cell.viwBG.layer.shadowOffset = CGSize(width: -1, height: 1)

        
        cell.selectionStyle = .none
        return cell
    }
    //MARK: - Search bar delegate method

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
    //This method will help us to find search text text
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         arrSearchCategory.removeAllObjects()
        if searchText == "" //If empty text search then dislpay all records
        {
            arrSearchCategory = arrCategory
            self.tblCategory.reloadData()
            return
        }

        for item in arrCategory
        {
            let arr : NSArray = item as! [clsCategotyEntity] as NSArray
           
            var arrCat = [clsCategotyEntity]()
            
            //Apply predicates for search strCategory , ID , item_desc
            let resultPredicate = NSPredicate(format: "strCategory contains[c]%@ OR id contains[c] %@ OR item_desc contains[c]%@",searchText,searchText,searchText)

            arrCat = arr.filtered(using: resultPredicate) as! [clsCategotyEntity]
            arrSearchCategory.add(arrCat)
        }
        self.tblCategory.reloadData()
    }
    
}
extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                DispatchQueue.main.async(execute: { () -> Void in
                    self.image = UIImage(named: "defaultImage")
                })
                
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}
