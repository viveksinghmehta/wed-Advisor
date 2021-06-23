//
//  CoupleDashboardCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 27/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class CoupleDashboardCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblCompare: UILabel!
    
        override func awakeFromNib() {
            super.awakeFromNib()
            bgView.layer.masksToBounds = false
            bgView.layer.borderColor = WedAdviserColor.cellBorderColor().cgColor
                   bgView.layer.borderWidth = 1.0
            bgView.layer.shadowColor = WedAdviserColor.cellDownRightShadowColor().cgColor
                              bgView.layer.shadowOffset = CGSize(width: 3, height: 3);
                                 bgView.layer.shadowOpacity = 1;
                                 bgView.layer.shadowRadius = 1.0;
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

    }
