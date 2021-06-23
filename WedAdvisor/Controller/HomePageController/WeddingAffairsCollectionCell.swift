//
//  WeddingAffairsCollectionCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandy on 14/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class WeddingAffairsCollectionCell: UICollectionViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgImage: SwiftShadowImageView!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblRequest: UILabel!
    
        override func awakeFromNib() {
            super.awakeFromNib()
            self.imgImage.roundCorners(corners: [.topLeft, .topRight], radius: 15)
        }
        
    }
