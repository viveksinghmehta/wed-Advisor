//
//  RegisterController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 13/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//
import UIKit
import MaterialComponents.MaterialTextFields

class RegisterController: UIViewController,UITextFieldDelegate{
    
    //Register Outlet
    @IBOutlet weak var registerContainerView: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var showPasswordBtn: UIButton!
    @IBOutlet weak var showConfirmPasswordBtn: UIButton!
    @IBOutlet weak var privacyPolicyBtn: UIButton!

    // Login Outlet
    @IBOutlet weak var loginContainerView: UIView!
    @IBOutlet weak var txtLoginEmail: UITextField!
    @IBOutlet weak var txtLoginPassword: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var showPasswordBtnForLogin: UIButton!
    @IBOutlet weak var ImgRememberMe: UIImageView!
    
    var isLogin: Bool?
    var rememberMe = true
    var showPassword = true
    var confirmShowPassword = true
    var ShowPasswordForLogin = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerContainerView.isHidden = false
        loginContainerView.isHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func showPasswordBtnTapped(button: UIButton) {
        if(showPassword == true)
        {
            showPassword = false
            showPasswordBtn.setImage(#imageLiteral(resourceName: "ic_showPassword"), for: .normal)
            txtPassword.isSecureTextEntry = false
        }
        else
        {
            showPassword = true
            showPasswordBtn.setImage(#imageLiteral(resourceName: "ic_hidePassword"), for: .normal)
            txtPassword.isSecureTextEntry = true
        }
    }
    @IBAction func showConfirmPasswordBtnTapped(button: UIButton) {
        if(confirmShowPassword == true)
        {
            confirmShowPassword = false
            showConfirmPasswordBtn.setImage(#imageLiteral(resourceName: "ic_showPassword"), for: .normal)
            txtConfirmPassword.isSecureTextEntry = false
        }
        else
        {
            confirmShowPassword = true
            showConfirmPasswordBtn.setImage(#imageLiteral(resourceName: "ic_hidePassword"), for: .normal)
            txtConfirmPassword.isSecureTextEntry = true
        }
    }
    
    @IBAction func showPasswordBtnForLoginTapped(button: UIButton) {
        if(ShowPasswordForLogin == true)
        {
            ShowPasswordForLogin = false
            showPasswordBtnForLogin.setImage(#imageLiteral(resourceName: "ic_showPassword"), for: .normal)
            txtLoginPassword.isSecureTextEntry = false
        }
        else
        {
            ShowPasswordForLogin = true
            showPasswordBtnForLogin.setImage(#imageLiteral(resourceName: "ic_hidePassword"), for: .normal)
            txtLoginPassword.isSecureTextEntry = true
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            if textField == txtName {
                txtEmail.becomeFirstResponder()
            } else if textField == txtEmail {
                txtPassword.becomeFirstResponder()
            }else if textField == txtPassword {
                txtConfirmPassword.becomeFirstResponder()
            }
        } else if textField.returnKeyType == .done {  //enterMobileTxtFld active
            textField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func registerBtnTapped(sender: UIButton){
        loginContainerView.isHidden = true
        registerContainerView.isHidden = false
    }
    @IBAction func loginBtnTapped(sender: UIButton){
        loginContainerView.isHidden = false
        registerContainerView.isHidden = true
    }
    @IBAction func rememberBtnTapped(sender: UIButton){
    }
    
    @IBAction func forgotPasswordBtnTapped(sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordController") as? ForgotPasswordController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
     @IBAction func privacyPolicyBtnTapped(sender: UIButton){
        if(rememberMe == true)
        {
            rememberMe = false
            privacyPolicyBtn.setImage(#imageLiteral(resourceName: "ic_check"), for: .normal)
        }
        else
        {
            rememberMe = true
            privacyPolicyBtn.setImage(#imageLiteral(resourceName: "t_ic-checked"), for: .normal)
        }
    }
    
    
    @IBAction func signInBtnTapped(sender: UIButton){
        if validationEmail(){
            login()
        }
//        let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func signUpBtnTapped(sender: UIButton){
        if validation(){
            register()
        }
    }
    
    //MARK:- VALIDATION
    func validation() -> Bool{
        if (txtName.text == ""){
            alertShow(msg: "Please enter Name")
            return false
        }
        else if (txtEmail.text == ""){
            alertShow(msg: "Please enter Email")
            return false
        }
        else if (txtPassword.text == ""){
            alertShow(msg: "Please enter Password")
            return false
        }
        else if (isValidEmail(txtEmail.text ?? "") == false){
            alertShow(msg: "Email is not correct!")
            return false
        }
        else if txtPassword.text?.count ?? 0 < 7{
            alertShow(msg: "Password must be minimum 8 characters")
            return false
        }
        else if txtPassword.text != txtConfirmPassword.text{
            alertShow(msg: "Confirmed password not same")
            return false
        }
        return true
    }
    
    
    //MARK:- VALIDATION Email
     func validationEmail() -> Bool{
        if (txtLoginEmail.text == ""){
             alertShow(msg: "Please enter Email")
             return false
         }

         else if (isValidEmail(txtLoginEmail.text ?? "") == false){
             alertShow(msg: "Email is not correct!")
             return false
         }
            else if (txtLoginPassword.text == ""){
                alertShow(msg: "Please enter Password")
                return false
            }
         else if txtLoginPassword.text?.count ?? 0 < 7{
             alertShow(msg: "Password must be minimum 8 characters")
             return false
         }
         return true
     }
    
    func alertShow(msg : String){
        // the alert view
  self.present(UIAlertController.alertWithTitle(title: "", message: msg , buttonTitle: "OK"), animated: true, completion: nil)
    }
}


extension RegisterController{
    func register()
    {
        let dictparam = ["name":txtName.text ?? "",
                         "email":txtEmail.text ?? "",
                         "password": txtPassword.text ?? "",
                         "password_confirmation": txtConfirmPassword ?? ""
            ] as [String:Any]
        
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.SignUpUser(with: dictparam, success: { (signUpData) in
            self.hideActivityIndicator(uiView: self.view)
            print(signUpData)
            if signUpData.access_token != nil{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
                //  self.alertShow(msg: "Registration successfully")
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            else{
                self.alertShow(msg: "Email already existed")
            }
        }){ (error) in
            self.hideActivityIndicator(uiView: self.view)
        }
    }
    
    func login()
    {
        let dictparam = ["email":txtLoginEmail.text ?? "",
                         "password": txtLoginPassword.text ?? ""
            ] as [String:Any]
        
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.LoginUser(with: dictparam, success: { (signUpData) in
            self.hideActivityIndicator(uiView: self.view)
            print(signUpData)
            if signUpData.access_token != nil{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
                UserDefaults.standard.set(signUpData.access_token, forKey: "BearerToken")
                print(UserDefaults.standard.string(forKey: "BearerToken"))
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            else{
                self.alertShow(msg: "Login Failed")
            }
        }){ (error) in
            self.hideActivityIndicator(uiView: self.view)
        }
    }
}

