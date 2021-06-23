//
//  PhoneCell.swift
//  WedAdvisor
//
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class PhoneCell: UITableViewCell {

    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblPhone: UILabel!
    var removeClosure:(()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnDelete(_ sender: Any) {
        removeClosure!()

    }
}
