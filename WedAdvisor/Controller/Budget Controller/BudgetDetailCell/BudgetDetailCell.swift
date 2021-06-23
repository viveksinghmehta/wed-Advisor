//
//  BudgetDetailCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 21/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class BudgetDetailCell: UITableViewCell {
    
    
    @IBOutlet weak var budgetDetailStackView: UIStackView!
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var forthView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.firstView.roundCorners(corners: [.topLeft, .topRight], radius: 17)
        self.forthView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 17)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
