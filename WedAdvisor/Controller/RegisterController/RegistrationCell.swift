//
//  RegistrationCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 01/02/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import MaterialComponents
import TweeTextField

class RegistrationCell: UITableViewCell {
    @IBOutlet weak var txtName: TweeBorderedTextField!
    
    @IBOutlet weak var btnShowPassword: UIButton!
    var tableCell: MDCTextInputControllerOutlined!

        override func awakeFromNib() {
            super.awakeFromNib()
            txtName.lineWidth = 0
            // Initialization code
        }
    
        

//        override func setSelected(_ selected: Bool, animated: Bool) {
//            super.setSelected(selected, animated: animated)
//            DispatchQueue.main.async {
//                   //   self.tableCell = MDCTextInputControllerOutlined(textInput: self.txtName)
//                      let allTextFieldController: [MDCTextInputControllerOutlined] = [self.tableCell]
//                      for textFieldController in allTextFieldController {
//                          textFieldController.activeColor = .black
//                          textFieldController.floatingPlaceholderActiveColor = .black
//                      }
//                      // Do any additional setup after loading the view.
//                  }
//            // Configure the view for the selected state
//        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
               textField.resignFirstResponder()
               return true
           }

    }
