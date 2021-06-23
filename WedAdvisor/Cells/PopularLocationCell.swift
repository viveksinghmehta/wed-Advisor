//
//  PopularLocationCell.swift
//  WedAdvisor
//
//  Created by WishACloud on 22/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class PopularLocationCell: UITableViewCell {

    
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var numberOfVendorsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cityImageView.layer.cornerRadius = 8
        cityImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
