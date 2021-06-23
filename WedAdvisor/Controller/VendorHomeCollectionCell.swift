//
//  VendorHomeCollectionCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 27/02/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class VendorHomeCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imgVendor: UIImageView!
    @IBOutlet weak var lblVendorName: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var btnFav: UIButton!
    

    

    override func awakeFromNib() {
        super.awakeFromNib()
        imgVendor.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight ], radius: 10)    }
    
    
    @IBAction func btnFav(_ sender: Any) {
        

    }
    
}
