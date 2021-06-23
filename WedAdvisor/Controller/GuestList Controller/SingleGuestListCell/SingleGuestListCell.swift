//
//  SingleGuestListCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 25/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class SingleGuestListCell: UITableViewCell {
    
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var groomFamilyView: UIView!
    @IBOutlet weak var RSVPWaitingView: UIView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnYesNO: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var guestNameLbl: UILabel!
    @IBOutlet weak var guestEmailLbl: UILabel!
    @IBOutlet weak var lblGuestName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblrelation: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    var ViewDeleteClosure:(()->())?
    var ViewEditClosure:(()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        design()
        // Initialization code
    }
    
    @IBAction func btnEdit(_ sender: Any) {
    ViewEditClosure!()
    }
    
    @IBAction func btnDelete(_ sender: Any) {
    ViewDeleteClosure!()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func design(){
        self.groomFamilyView.layer.borderColor = WedAdviserColor.guestGroupViewBorderColor().cgColor
        self.RSVPWaitingView.layer.borderColor = WedAdviserColor.guestGroupViewBorderColor().cgColor
     //   btnYesNO.layer.borderColor = WedAdviserColor.LightGrayUnselectLblBackgroundColor().cgColor
        btnEdit.layer.borderColor =  WedAdviserColor.buttonselectBackgroundColor().cgColor
        btnDelete.layer.borderColor = WedAdviserColor.themeOrangeColor().cgColor
        
    }
    
}
