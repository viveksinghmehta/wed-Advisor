//
//  MyProfileController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 18/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class MyProfileController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
     @IBOutlet weak var textCoupleName: UITextField!
     @IBOutlet weak var textEmail: UITextField!
     @IBOutlet weak var textPhone: UITextField!
    @IBOutlet weak var textVwDescription: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
    var picker = UIImagePickerController()
    var imgdata: Data?
    var pickImageCallback : ((UIImage) -> ())?;
    var selectedImage : UIImage?
    var baseString : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSave.layer.cornerRadius = 6

        self.textVwDescription.layer.borderColor = WedAdviserColor.textFieldBorderColor().cgColor
        self.textVwDescription.layer.borderWidth = 0.5
        
        self.textCoupleName.layer.borderColor = WedAdviserColor.textFieldBorderColor().cgColor
        self.textCoupleName.layer.borderWidth = 0.5
        
        self.textEmail.layer.borderColor = WedAdviserColor.textFieldBorderColor().cgColor
        self.textEmail.layer.borderWidth = 0.5
        
        self.textPhone.layer.borderColor = WedAdviserColor.textFieldBorderColor().cgColor
        self.textPhone.layer.borderWidth = 0.5
        
        imgProfile.layer.cornerRadius = imgProfile.frame.size.height/2
        textPhone.setLeftPaddingPoints(15)
        textEmail.setLeftPaddingPoints(15)
        textCoupleName.setLeftPaddingPoints(15)
        profileListData()
    }
    @IBAction func backBtn(sender: UIButton){
          self.navigationController?.popViewController(animated: true)
      }
    
    @IBAction func btnPhoto(_ sender: Any) {
        picker.delegate = self
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)

    }
    
    //MARK:- Picker Function
       func openCamera()
       {
           if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
           {
               picker.sourceType = UIImagePickerController.SourceType.camera
               self .present(picker, animated: true, completion: nil)
           }
           else
           {
               let alertWarning = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
               alertWarning.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
               self.present(alertWarning, animated: true, completion: nil)
               
           }
       }
       func openGallary(){
           picker.sourceType = .photoLibrary
           self.present(picker, animated: true, completion: nil)
       }
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           picker.dismiss(animated: true, completion: nil)
           guard let image = info[.originalImage] as? UIImage else {
               fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
           }
           selectedImage = image
        imgProfile.image = image
           pickImageCallback?(image)
        
        let imageData: Data? = image.jpegData(compressionQuality: 0.4)
           let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
          // print(imageStr)
           baseString = imageStr
   
       }
       @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
       }
    
    @IBAction func btnSave(_ sender: Any) {
        if baseString != "" && baseString != nil{
            updateProfileImage()
        }
        else{
            alertShow(msg: "Please select Profil Pic to upload")
        }
    }
    
    func alertShow(msg : String){
          // the alert view
    self.present(UIAlertController.alertWithTitle(title: "", message: msg , buttonTitle: "OK"), animated: true, completion: nil)
      }
}
extension MyProfileController{
    func profileListData()
    {
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.MyProfile(success: { (myProfileData) in
            self.hideActivityIndicator(uiView: self.view)
            if let name = myProfileData.loggedUser?.name{
                self.textCoupleName.text = name
            }
            if let email = myProfileData.loggedUser?.email{
                self.textEmail.text = email
            }
            if let phone = myProfileData.loggedUser?.phone{
                self.textPhone.text = phone
            }
            if let desc = myProfileData.loggedUser?.description{
                self.textVwDescription.text = desc
            }
            
            if let imageProfile = myProfileData.loggedUser?.profile_image{
                
                self.imgProfile.sd_setImage(with: URL(string: "https://wed-advisor.com/images/\(imageProfile)"), placeholderImage: UIImage(named: "e869f0db1534199a6464981f7a75515d"))

              //  https://wed-advisor.com/images/MXjfVGCRkZkhrfThBplNgScgc7TyUq5V5RLsPLQz.png
            }
        })
            
        { (error) in
            self.hideActivityIndicator(uiView: self.view)
        }
    }
    
    
    
    func updateProfileImage()
    {
        let dictparam = ["image":"data:image/png;base64," + (baseString ?? "")
            ] as [String:Any]
      //  print(dictparam)
        
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.profileUpdate(with: dictparam, success: { (todoadd) in
            self.hideActivityIndicator(uiView: self.view)
            print(todoadd)
            if todoadd.status == 200{
                
                let alert = UIAlertController(title: "", message: "Profile Image Updated", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                // change to desired number of seconds (in this case 5 seconds)
                let when = DispatchTime.now() + 3
                DispatchQueue.main.asyncAfter(deadline: when){
                    // your code with delay
                    alert.dismiss(animated: true, completion: nil)
                    self.profileListData()
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }){ (error) in
            self.hideActivityIndicator(uiView: self.view)
        }
    }
}
extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}
