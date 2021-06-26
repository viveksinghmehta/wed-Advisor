//
//  AddedPhoneCell.swift
//  WedAdvisor
//
//  Created by WishACloud on 26/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

protocol PhoneNumberDelegate : NSObject {
    func deleteNumber(index: IndexPath)
}

final class AddedPhoneCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    var index: IndexPath = IndexPath(row: 0, section: 0)
    weak var delegate: PhoneNumberDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteNumber(_ sender: UIButton) {
        delegate?.deleteNumber(index: index)
    }
    
}
