//
//  WeddingCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 20/02/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import EZYGradientView
class WeddingCell: UICollectionViewCell {
    
    @IBOutlet weak var imgWedding: UIImageView!
    @IBOutlet weak var viewGradient: EZYGradientView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgWedding.layer.masksToBounds = true
        imgWedding.layer.cornerRadius = 12;
        viewGradient.layer.cornerRadius = 12
        
        self.viewGradient.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 17)

    }

}
