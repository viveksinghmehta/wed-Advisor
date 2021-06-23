//
//  ArrangeCategoryCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandy on 14/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class ArrangeCategoryCell: UICollectionViewCell {

    @IBOutlet weak var imgImage: UIImageView!
        
        override func awakeFromNib() {
            super.awakeFromNib()
            self.imgImage.roundCorners(corners: [.topLeft, .topRight], radius: 15)
        }

    }
