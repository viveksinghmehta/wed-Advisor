//
//  BlodCommentCellTableViewCell.swift
//  WedAdvisor
//
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class BlodCommentCellTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var imgPhoto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgPhoto.layer.cornerRadius = imgPhoto.frame.size.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
