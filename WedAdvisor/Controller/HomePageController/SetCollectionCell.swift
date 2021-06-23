//
//  SetCollectionCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandy on 14/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import EZYGradientView
class SetCollectionCell: UICollectionViewCell {
    @IBOutlet weak var viewIMAGE: SwiftShadowImageView!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var viewLayer: EZYGradientView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    viewLayer.layer.cornerRadius = 10;
        
        viewLayer.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
    }

}
