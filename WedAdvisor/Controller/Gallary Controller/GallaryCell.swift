//
//  GallaryCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 18/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class GallaryCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var gallaryImage : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
      gallaryImage.layer.masksToBounds = true
        gallaryImage.layer.cornerRadius = 15;
        bgView.layer.cornerRadius = 15
        // Initialization code
    }

}
