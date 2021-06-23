//
//  NameCollectionCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandy on 14/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import EZYGradientView

class NameCollectionCell: UICollectionViewCell {
    @IBOutlet weak var viewBack: UIView!
        @IBOutlet weak var imgName: UIImageView!
        @IBOutlet weak var viewGradient: EZYGradientView!
        @IBOutlet weak var heightBack: NSLayoutConstraint!
        @IBOutlet weak var lblCity: UILabel!
        @IBOutlet weak var lblVendor: UILabel!
        @IBOutlet weak var lblName: UILabel!
        @IBOutlet weak var lblCityTwo: UILabel!
        @IBOutlet weak var lblPrice: UILabel!
        
        override func awakeFromNib() {
            super.awakeFromNib()
         //   viewBack.layer.cornerRadius = 10
        //    imgName.layer.cornerRadius = 10
        //    viewGradient.layer.cornerRadius = 20
            self.viewBack.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 15)

        }

    }
