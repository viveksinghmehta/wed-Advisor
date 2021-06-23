//
//  FaqTableCell.swift
//  WedAdvisor
//

//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class FaqTableCell: UITableViewCell {
    @IBOutlet weak var lblQues: UILabel!
    @IBOutlet weak var lblAns: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
