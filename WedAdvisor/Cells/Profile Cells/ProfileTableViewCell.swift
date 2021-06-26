//
//  ProfileTableViewCell.swift
//  WedAdvisor
//
//  Created by WishACloud on 25/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var backContentView: RoundedView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editImage: UIImageView!
    @IBOutlet weak var nameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTF: SkyFloatingLabelTextField!
    var changeProfile: (() -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UIInit()
        textFieldInit()
    }
    
    
    fileprivate func UIInit() {
        profileImageView.makeRounded(cornerRadius: 110 / 2, color: WedAdviserColor.themeOrangeColor())
        editImage.makeRounded(cornerRadius: 20, color: .clear)
    }
    
    
    fileprivate func textFieldInit() {
        nameTF.placeholder = "Couple Name"
        nameTF.selectedTitleColor = WedAdviserColor.themeOrangeColor()
        nameTF.placeholderFont = UIFont(name: "ProductSans-Regular", size: 17)
        nameTF.selectedLineColor = WedAdviserColor.themeOrangeColor()
        emailTF.placeholder = "Email"
        emailTF.selectedTitleColor = WedAdviserColor.themeOrangeColor()
        emailTF.placeholderFont = UIFont(name: "ProductSans-Regular", size: 17)
        emailTF.selectedLineColor = WedAdviserColor.themeOrangeColor()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func changeProfileAction(_ sender: UIButton) {
        guard let changeProfile = changeProfile else { return }
        changeProfile()
    }
    
}
