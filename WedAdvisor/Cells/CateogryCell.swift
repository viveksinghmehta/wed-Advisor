//
//  CateogryCell.swift
//  WedAdvisor
//
//  Created by WishACloud on 22/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class CateogryCell: UICollectionViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var cateogryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryImageView.makeRounded(cornerRadius: (self.bounds.width / 4.8), color: WedAdviserColor.themeOrangeColor())
    }
    
}
