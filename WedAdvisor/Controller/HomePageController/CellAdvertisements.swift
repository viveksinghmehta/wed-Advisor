//
//  CellAdvertisements.swift
//  WedAdvisor
//

//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class CellAdvertisements: UICollectionViewCell {
    @IBOutlet weak var imgImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgImage.layer.cornerRadius = 10
    }

}
