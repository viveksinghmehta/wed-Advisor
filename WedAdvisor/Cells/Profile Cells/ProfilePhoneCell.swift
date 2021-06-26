//
//  ProfilePhoneCell.swift
//  WedAdvisor
//
//  Created by WishACloud on 26/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ProfilePhoneCell: UITableViewCell {

    @IBOutlet weak var phoneTableView: ExpandingTableView!
    @IBOutlet weak var phoneTF: SkyFloatingLabelTextField!
    @IBOutlet weak var submitButton: UIButton!
    
    
    private let identifier: String = "phone"
    var mobileInfo: [usermobileInfo]?
    var addPhoneNo: ((String) -> Void)?
    var deletePhone: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        phoneTableView.register(UINib(nibName: "AddedPhoneCell", bundle: nil), forCellReuseIdentifier: identifier)
        phoneTableView.delegate = self
        phoneTableView.dataSource = self
        phoneTableView.rowHeight = 44
        phoneTableView.reloadData()
        submitButton.layer.cornerRadius = 8
        submitButton.layer.masksToBounds = true
        phoneTF.selectedTitleColor = WedAdviserColor.themeOrangeColor()
        phoneTF.selectedLineColor = WedAdviserColor.themeOrangeColor()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func submitPhone(_ sender: UIButton) {
        phoneTF.resignFirstResponder()
        guard let phone = addPhoneNo else { return }
        phone(Helper.optionalStringToString(value: phoneTF.text))
    }
    
}

extension ProfilePhoneCell : UITableViewDelegate, UITableViewDataSource, PhoneNumberDelegate {
    
    
    func deleteNumber(index: IndexPath) {
        guard let delete = deletePhone else { return }
        delete(Helper.optionalIntToInt(value: mobileInfo?[index.row].id))
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let mobile = mobileInfo {
            return mobile.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? AddedPhoneCell else { return UITableViewCell() }
        cell.numberLabel.text = Helper.optionalStringToString(value: mobileInfo?[indexPath.row].mobile)
        cell.delegate = self
        return cell
    }
    
    
}
