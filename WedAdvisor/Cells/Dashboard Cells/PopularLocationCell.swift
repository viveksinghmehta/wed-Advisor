//
//  PopularLocationCell.swift
//  WedAdvisor
//
//  Created by WishACloud on 23/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class PopularLocationCell: UICollectionViewCell {

    
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var vendorNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cityImageView.layer.cornerRadius = 8
        cityImageView.layer.masksToBounds = true
    }

}
