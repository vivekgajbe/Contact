//
//  clsContactTableViewCell.swift
//  Contact
//
//  Created by Mayur Susare on 25/09/18.
//  Copyright © 2018 Vivek Gajbe. All rights reserved.
//

import UIKit

class clsContactTableViewCell: UITableViewCell {
    //MARK: - variable declaration
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnSMS: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
