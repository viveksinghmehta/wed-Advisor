//
//  BlogDetailCollectionViewCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 20/02/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class BlogDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgWedding: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgWedding.layer.masksToBounds = true
        imgWedding.layer.cornerRadius = 15;
        // Initialization code
    }

}
