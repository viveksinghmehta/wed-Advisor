//
//  ReviewCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 14/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    
     @IBOutlet weak var bgView: SwiftShadowImageView!
    @IBOutlet weak var starReviewView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.borderColor = WedAdviserColor.reviewCellBorderColor().cgColor
      //  self.starReviewView.layer.borderColor = WedAdviserColor.reviewCellBorderColor().cgColor
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
