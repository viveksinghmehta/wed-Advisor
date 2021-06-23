//
//  MyWishListCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 26/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class MyWishListCell: UICollectionViewCell {

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgImage: UIImageView!
    
    var removeClosure:(()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func btnFav(_ sender: Any) {
        removeClosure!()

    }
    
}
