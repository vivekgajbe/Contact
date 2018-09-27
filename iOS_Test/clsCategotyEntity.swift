//
//  clsCategotyEntity.swift
//  Contact
//
//  Created by Mayur Susare on 26/09/18.
//  Copyright © 2018 Vivek Gajbe. All rights reserved.
//

import UIKit

class clsCategotyEntity: NSObject {

    @objc var strCategory = String()
    
    @objc var id = String()
    var inv_mast_uid : Int?
    var item_id : String?
    @objc var item_desc = String()
    var unit : String?
    var image : String?
    var notes : String?
    
    override init() {
        id = ""
        item_id = ""
        item_desc = ""
        unit = ""
        image = ""
        notes = ""
        
        
    }
}
