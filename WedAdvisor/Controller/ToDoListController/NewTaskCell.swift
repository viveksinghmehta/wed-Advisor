//
//  NewTaskCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 20/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class NewTaskCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnInactive: UIButton!
    @IBOutlet weak var btnActive: UIButton!
    var ViewDeleteClosure:(()->())?
    var ViewEditClosure:(()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnEdit(_ sender: Any) {
        ViewEditClosure!()

    }
    @IBAction func btnDelete(_ sender: Any) {
        ViewDeleteClosure!()
    }
}
