//
//  OtpPopUp.swift
//  WedAdvisor
//
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
protocol dismiss {
    func dismissPop()
}


class OtpPopUp: UIViewController {
    @IBOutlet weak var viewPop: UIView!
    @IBOutlet weak var viewone: UIView!
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var viewThree: UIView!
    @IBOutlet weak var viewFour: UIView!
    @IBOutlet weak var txtOne: UITextField!
    @IBOutlet weak var txtTwo: UITextField!
    @IBOutlet weak var txtThree: UITextField!
    @IBOutlet weak var txtFour: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var selector: String?
    var otp : String?
    var phone: String?
    var delegatedismiss : dismiss?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        viewone.layer.cornerRadius = 5
        viewTwo.layer.cornerRadius = 5
        viewThree.layer.cornerRadius = 5
        viewFour.layer.cornerRadius = 5
        btnSubmit.layer.cornerRadius = 10
        viewPop.layer.cornerRadius = 10
        setUp()
    }
    
    //MARK:- Setup Function
    func setUp(){
        txtOne.delegate = self
        txtTwo.delegate = self
        txtThree.delegate = self
        txtFour.delegate = self
        txtOne.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtTwo.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtThree.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtFour.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
    @IBAction func btnDismiss(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSubmit(_ sender: Any) {
      
    }
    @IBAction func btnResend(_ sender: Any) {
        if validation(){
            addOtp()
        }
    }
}

// MARK:- OTP
extension OtpPopUp: UITextFieldDelegate{
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if (text?.utf16.count)! >= 1{
            switch textField{
            case txtOne:
                txtTwo.becomeFirstResponder()
            case txtTwo:
                txtThree.becomeFirstResponder()
            case txtThree:
                txtFour.becomeFirstResponder()
            case txtFour:
                txtFour.resignFirstResponder()
            default:
                break
            }
        }
        if  text?.count == 0 {
            switch textField{
            case txtOne:
                txtOne.becomeFirstResponder()
            case txtTwo:
                txtOne.becomeFirstResponder()
            case txtThree:
                txtTwo.becomeFirstResponder()
            case txtFour:
                txtThree.becomeFirstResponder()
            default:
                break
            }
        }
        else{
            
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textstring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let length = textstring.count
        if textField == txtOne || textField == txtTwo || textField == txtThree || textField == txtFour{
            if length > 1 {
                return false
            }
        }
        return true
    }
    
     //MARK:- VALIDATION
     func validation() -> Bool{
         if (txtOne.text == ""){
             alertShow(msg: "Please enter OTP")
             return false
         }
       else if (txtTwo.text == ""){
            alertShow(msg: "Please enter OTP")
            return false
        }
       else if (txtThree.text == ""){
            alertShow(msg: "Please enter OTP")
            return false
        }
       else if (txtFour.text == ""){
            alertShow(msg: "Please enter OTP")
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


extension OtpPopUp{
    func addOtp()
    {
        otp = "\(txtOne.text ?? "")\(txtTwo.text ?? "")\(txtThree.text ?? "")\(txtFour.text ?? "")"
        let dictparam = ["selector": selector ?? 0,
                         "otp": otp ?? 0] as [String:Any]
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.phoneOtp(with: dictparam, success: { (todoadd) in
            self.hideActivityIndicator(uiView: self.view)
            print(todoadd)
            if todoadd.message != "Server Error"{
                self.delegatedismiss?.dismissPop()
                self.dismiss(animated: true, completion: nil)
            }
            else{
                self.alertShow(msg: "Please enter Correct OTP")
            }
        }){ (error) in
            self.hideActivityIndicator(uiView: self.view)
        }
    }
}
