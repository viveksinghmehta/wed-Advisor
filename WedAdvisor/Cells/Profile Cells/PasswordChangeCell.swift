//
//  PasswordChangeCell.swift
//  WedAdvisor
//
//  Created by WishACloud on 26/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

final class PasswordChangeCell: UITableViewCell {

    @IBOutlet weak var backContentView: RoundedView!
    @IBOutlet weak var newPasswordTF: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPasswordTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var submitButton: UIButton!
    var changePassword: ((_ password: String) -> Void)?
    var passwordErrorMsg: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        submitButton.layer.cornerRadius = 8
        submitButton.layer.masksToBounds = true
        newPasswordTF.isSecureTextEntry = true
        confirmPasswordTF.isSecureTextEntry = true
        newPasswordTF.selectedTitleColor = WedAdviserColor.themeOrangeColor()
        newPasswordTF.selectedLineColor = WedAdviserColor.themeOrangeColor()
        confirmPasswordTF.selectedTitleColor = WedAdviserColor.themeOrangeColor()
        confirmPasswordTF.selectedLineColor = WedAdviserColor.themeOrangeColor()
    }

    
    @IBAction func showChangePassword(_ sender: UIButton) {
        if newPasswordTF.isSecureTextEntry {
            newPasswordTF.isSecureTextEntry = false
            sender.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        } else {
            newPasswordTF.isSecureTextEntry = true
            sender.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
    
    
    @IBAction func showConfirmPassword(_ sender: UIButton) {
        if confirmPasswordTF.isSecureTextEntry {
            confirmPasswordTF.isSecureTextEntry = false
            sender.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        } else {
            confirmPasswordTF.isSecureTextEntry = true
            sender.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
    
    
    @IBAction func submitAction(_ sender: UIButton) {
        newPasswordTF.resignFirstResponder()
        confirmPasswordTF.resignFirstResponder()
        if Helper.optionalStringToString(value: newPasswordTF.text) == Helper.optionalStringToString(value: confirmPasswordTF.text) {
            guard let changepassword = changePassword else {
                return
            }
            changepassword(Helper.optionalStringToString(value: newPasswordTF.text))
            newPasswordTF.text = nil
            confirmPasswordTF.text = nil
        } else {
            guard let error = passwordErrorMsg else { return }
            error("Your password do not match.")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
