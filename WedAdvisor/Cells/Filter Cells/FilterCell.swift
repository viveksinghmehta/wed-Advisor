//
//  FilterCell.swift
//  WedAdvisor
//
//  Created by WishACloud on 29/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

final class FilterCell: UITableViewCell {

    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var checked: Bool = false {
        didSet { selectOption() }
    }
    
    fileprivate func selectOption() {
        if checked {
            checkImageView.image = UIImage(named: "filter_selected")
        } else {
            checkImageView.image = UIImage(named: "filter_unselected")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectOption()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
