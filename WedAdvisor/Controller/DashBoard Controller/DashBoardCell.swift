//
//  DashBoardCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 21/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class DashBoardCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileNamesLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.masksToBounds = false
        bgView.layer.borderColor = WedAdviserColor.cellBorderColor().cgColor
               bgView.layer.borderWidth = 1.0
        bgView.layer.shadowColor = WedAdviserColor.cellDownRightShadowColor().cgColor
                          bgView.layer.shadowOffset = CGSize(width: 8, height: 8);
                             bgView.layer.shadowOpacity = 1;
                             bgView.layer.shadowRadius = 1.0;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
