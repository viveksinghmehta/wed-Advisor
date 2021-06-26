//
//  CategoryCell.swift
//  WedAdvisor
//
//  Created by WishACloud on 23/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var cateogryName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryImageView.makeRounded(cornerRadius: (((UIScreen.main.bounds.width - 32) / 3) - 8) / 2, color: WedAdviserColor.themeOrangeColor())
    }

}
