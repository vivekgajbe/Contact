//
//  ViewController.swift
//  iOS_Test
//
//  Created by Ravi Jayaraman on 27/09/18.
//  Copyright © 2018 Winjit Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - init method
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- Button delegate method
    
    /// IBAction is used for navigate to Test1ViewController screen
    ///
    /// - Parameter sender: Any
    @IBAction func btnTest1Click(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Test1ViewController") as! Test1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /// IBAction is used for navigate to Test2ViewController screen
    ///
    /// - Parameter sender: Any
    @IBAction func btnTest2Click(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Test2ViewController") as! Test2ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

