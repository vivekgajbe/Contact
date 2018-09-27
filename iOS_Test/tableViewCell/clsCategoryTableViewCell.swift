//
//  clsCategoryTableViewCell.swift
//  Contact
//
//  Created by Mayur Susare on 26/09/18.
//  Copyright © 2018 Vivek Gajbe. All rights reserved.
//

import UIKit

class clsCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductID: UILabel!
    @IBOutlet weak var lblTermId: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblUnit: UILabel!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var viwBG: UIView!
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
