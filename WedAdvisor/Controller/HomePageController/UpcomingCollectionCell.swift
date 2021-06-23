//
//  UpcomingCollectionCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandy on 14/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class UpcomingCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblUpComing: UILabel!
    @IBOutlet weak var imgName: UILabel!
    override func awakeFromNib() {
           super.awakeFromNib()
        imgImage.layer.cornerRadius = imgImage.frame.size.height/2
       }
}
