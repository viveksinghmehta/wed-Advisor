//
//  CoupleGuestListCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 25/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class CoupleGuestListCell: UITableViewCell {

    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var confirmedView: UIView!
    @IBOutlet weak var groomFamilyView: UIView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var imgGuest: UIImageView!
    @IBOutlet weak var guestNameLbl: UILabel!
    @IBOutlet weak var guestEmailLbl: UILabel!
    
    @IBOutlet weak var invitedView: UIView!
    @IBOutlet weak var invitedCountLbl: UILabel!
    @IBOutlet weak var membersView: UIView!
    @IBOutlet weak var membersCountLbl: UILabel!
    @IBOutlet weak var btnIncreaseMember: UIButton!
    @IBOutlet weak var btnDecreaseMember: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        design()
        // Initialization code
    }
    func design(){
        self.groomFamilyView.layer.borderColor = WedAdviserColor.guestGroupViewBorderColor().cgColor
        self.confirmedView.layer.borderColor = WedAdviserColor.confirmedViewBorderAndTextColor().cgColor
            btnEdit.layer.borderColor =  WedAdviserColor.editButtonBorderAndTextColor().cgColor
         btnDelete.layer.borderColor = WedAdviserColor.deleteButtonBorderAndTextColor().cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
