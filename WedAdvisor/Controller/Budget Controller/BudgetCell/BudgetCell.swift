//
//  BudgetCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 21/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class BudgetCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.masksToBounds = false
        bgView.layer.borderColor = WedAdviserColor.budgetCellBorderColor().cgColor
                      bgView.layer.borderWidth = 1.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
