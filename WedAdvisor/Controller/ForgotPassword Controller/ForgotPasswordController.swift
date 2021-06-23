//
//  ForgotPasswordController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 20/02/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class ForgotPasswordController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txtName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backBtn(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendBtnBtnTapped(sender: UIButton){
        if validation(){
            forgot()
        }
    }
    //MARK:- VALIDATION
    func validation() -> Bool{
        if (txtName.text == ""){
            alertShow(msg: "Please enter Email")
            return false
        }
            
        else if (isValidEmail(txtName.text ?? "") == false){
            alertShow(msg: "Email is not correct!")
            return false
        }
        return true
    }
    func alertShow(msg : String){
        // the alert view
        self.present(UIAlertController.alertWithTitle(title: "", message: msg , buttonTitle: "OK"), animated: true, completion: {
            self.navigationController?.popViewController(animated: true)
        })
    }
}


extension ForgotPasswordController{
    func forgot()
    {
        let dictparam = ["email":txtName.text ?? ""
            ] as [String:Any]
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.ForgotUser(with: dictparam, success: { (signUpData) in
            self.hideActivityIndicator(uiView: self.view)
            print(signUpData)
            if signUpData.status == 200{
                self.alertShow(msg: signUpData.message ?? "")
            }
            else{
                self.alertShow(msg: signUpData.message ?? "")
            }
        }){ (error) in
            self.hideActivityIndicator(uiView: self.view)
        }
    }
}
