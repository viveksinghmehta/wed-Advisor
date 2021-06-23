//
//  FilterListingCell.swift
//  WedAdvisor
//
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class FilterListingCell: UITableViewCell {
    @IBOutlet weak var imgbox: UIImageView!
       @IBOutlet weak var lblType: UILabel!
       @IBOutlet weak var btnSelect: UIButton!
    static let filterInstanse = FilterListingCell()
       var selectClosure : (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnSelect(_ sender: Any) {
            selectClosure!()
       }
    
}
