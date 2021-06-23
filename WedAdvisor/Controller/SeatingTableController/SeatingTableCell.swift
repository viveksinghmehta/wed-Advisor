//
//  SeatingTableCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 22/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class SeatingTableCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var editDeleteBgView: UIView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.design()
        // Initialization code
    }
    
    func design(){
        self.bgView.layer.borderColor = WedAdviserColor.cellBorderColor().cgColor
        self.bgView.layer.borderWidth = 1
        
//        self.btnEdit.layer.borderColor = WedAdviserColor.buttonselectBackgroundColor().cgColor
//          self.btnDelete.layer.borderColor = WedAdviserColor.themeOrangeColor().cgColor
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
