//
//  ChangePasswordController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 18/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class ChangePasswordController: UIViewController {
    
    @IBOutlet weak var textCurrentPass: UITextField!
     @IBOutlet weak var textNewPass: UITextField!
     @IBOutlet weak var textRetypePass: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textCurrentPass.layer.borderColor = WedAdviserColor.textFieldBorderColor().cgColor
                     self.textCurrentPass.layer.borderWidth = 0.5
        self.textNewPass.layer.borderColor = WedAdviserColor.textFieldBorderColor().cgColor
                          self.textNewPass.layer.borderWidth = 0.5
        self.textRetypePass.layer.borderColor = WedAdviserColor.textFieldBorderColor().cgColor
                          self.textRetypePass.layer.borderWidth = 0.5
        textCurrentPass.setLeftPaddingPoints(15)
        textNewPass.setLeftPaddingPoints(15)
        textRetypePass.setLeftPaddingPoints(15)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        if validation(){
            changePassword()
        }
    }
    
    
    //MARK:- VALIDATION
     func validation() -> Bool{
         if (textCurrentPass.text == ""){
             alertShow(msg: "Please enter CurrentPassword")
             return false
         }
         else if (textNewPass.text == ""){
             alertShow(msg: "Please enter NewPassword")
             return false
         }
         else if (textRetypePass.text == ""){
             alertShow(msg: "Please enter RetypePassword")
             return false
         }
      
         else if textNewPass.text != textRetypePass.text{
             alertShow(msg: "Confirmed password not same")
             return false
         }
         return true
     }
    
      func alertShow(msg : String){
          // the alert view
    self.present(UIAlertController.alertWithTitle(title: "", message: msg , buttonTitle: "OK"), animated: true, completion: nil)
      }

}
extension ChangePasswordController{
    func changePassword()
{
    let dictparam = ["newpassword":textNewPass.text ?? "",
                     "repassword": textRetypePass.text ?? ""
        ] as [String:Any]
    
    self.showActivityIndicator(uiView: self.view)
    APIManager.sharedInstance.changePassword(with: dictparam, success: { (passwordchange) in
        self.hideActivityIndicator(uiView: self.view)
        print(passwordchange)
        if passwordchange.status == 200{
            
            let alert = UIAlertController(title: "", message: "Password change successfully", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            // change to desired number of seconds (in this case 5 seconds)
            let when = DispatchTime.now() + 3
            DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
                alert.dismiss(animated: true, completion: nil)
            }
            
        }

    }){ (error) in
        self.hideActivityIndicator(uiView: self.view)
    }
}
}
