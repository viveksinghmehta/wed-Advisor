//
//  VendorFilterCell.swift
//  WedAdvisor
//

//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class VendorFilterCell: UICollectionViewCell {

    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblHotel: UILabel!
    
    
    
 override func awakeFromNib() {
    super.awakeFromNib()
        imgImage.layer.cornerRadius = 10
        
    }

}
