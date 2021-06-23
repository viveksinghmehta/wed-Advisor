//
//  AmenitiesCell.swift
//  WedAdvisor
//

//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class AmenitiesCell: UICollectionViewCell {

    @IBOutlet weak var lblAminity: UILabel!
    @IBOutlet weak var imgEminity: UIImageView!
    var vendorId : Int?

    override func awakeFromNib() {
        super.awakeFromNib()
      print(vendorId)
    }
//    public func configure(withemodel : amenitiesData){
//        self.lblAminity.text = withemodel.amenities_option
//    }

}
