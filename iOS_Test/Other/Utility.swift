//
//  Utility.swift
//  iOS_Test
//
//  Created by Ravi Jayaraman on 27/09/18.
//  Copyright © 2018 Winjit Technologies. All rights reserved.
//

import UIKit

class Utility: NSObject {
    //Function to handle the scenario of when got some error
    func ShowAlert(title : String ,message:String ,onView:UIViewController)
    {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action2 = UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction) in
        }
        alertController.addAction(action2)
        onView.present(alertController, animated: true, completion: nil)
        
    }
}
