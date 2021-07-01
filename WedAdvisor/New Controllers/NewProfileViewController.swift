//
//  ProfileViewController.swift
//  WedAdvisor
//
//  Created by WishACloud on 25/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import DefaultsKit
import SDWebImage
import BetterSegmentedControl

final class NewProfileViewController: UIViewController {

    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var titleHeader: UIView!
    @IBOutlet weak var SegmentController: BetterSegmentedControl!
    
    enum Options {
        case profile
        case phone
        case password
    }
    var options: Options = .profile
    private let profileIdentifier: String = "profilecell"
    private let phoneIdentifier: String = "phonecell"
    private let passwordIdentifier: String = "passwordChange"
    private let socialMediaIdentifier: String = "profilesocialcell"
    private var profileModel: MyProfileModel?
    private var phoneResponse: AddPhone?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfile()
        segmentControllerInit()
        tableViewInit()
    }
    
    
    fileprivate func segmentControllerInit() {
        SegmentController.segments = LabelSegment.segments(withTitles: ["Profile", "Phone", "Password"], normalBackgroundColor: .white, normalFont: UIFont(name: "ProductSans-Regular", size: 14), normalTextColor: WedAdviserColor.themeOrangeColor(), selectedBackgroundColor: WedAdviserColor.themeOrangeColor(), selectedFont: UIFont(name: "ProductSans-Medium", size: 16), selectedTextColor: .white)
    }
    
    fileprivate func getProfile() {
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.MyProfile { [weak self] model in
            guard let weakself = self else { return }
            weakself.hideActivityIndicator(uiView: weakself.view)
            weakself.profileModel = model
            weakself.saveDetailsInDefault(model)
            weakself.profileTableView.reloadData()
        } failure: { [weak self] error in
            guard let weakself = self else { return }
            weakself.hideActivityIndicator(uiView: weakself.view)
            print(Helper.optionalStringToString(value: error?.msg))
        }

    }
    
    fileprivate func saveDetailsInDefault(_ model: MyProfileModel) {
        Defaults().set(model, for: .profile)
    }
    
    
    fileprivate func tableViewInit() {
        profileTableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: profileIdentifier)
        profileTableView.register(UINib(nibName: "PasswordChangeCell", bundle: nil), forCellReuseIdentifier: passwordIdentifier)
        profileTableView.register(UINib(nibName: "ProfileSocialCell", bundle: nil), forCellReuseIdentifier: socialMediaIdentifier)
        profileTableView.register(UINib(nibName: "ProfilePhoneCell", bundle: nil), forCellReuseIdentifier: phoneIdentifier)
        profileTableView.tableFooterView = UIView()
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.reloadData()
    }

    
    @IBAction func segmentValueChanged(_ sender: BetterSegmentedControl) {
        if sender.index == 0 {
            options = .profile
            profileTableView.reloadData()
        } else if sender.index == 1 {
            options = .phone
            profileTableView.reloadData()
        } else {
            options = .password
            profileTableView.reloadData()
        }
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension NewProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, OTPDismiss {
    
    func dismissPop() {
        getProfile()
    }
    
    
    fileprivate func changeProfilePic() {
        let alert = UIAlertController(title: "Profile Picture", message: "Please select an option to choose your photo for profile picture", preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: camera(_:)))
        alert.addAction(UIAlertAction(title: "Photo library", style: .default, handler: photolibrary(_:)))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    fileprivate func camera(_ action: UIAlertAction) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            imagePickerController.allowsEditing = true
            present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    fileprivate func photolibrary(_ action: UIAlertAction) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            showAlertWithOk(title: "Error", message: "Could not get the picture, please try again")
            self.dismiss(animated: true, completion: nil)
            return }
        let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 200, height: 200))
        let imageData = resizedImage.pngData()
        if let imageBase64String = imageData?.base64EncodedString() {
            let param: [String: Any] = ["image": "data:image/png;base64," + imageBase64String]
            self.showActivityIndicator(uiView: self.view)
            APIManager.sharedInstance.profileUpdate(with: param) { [weak self] model in
                guard let weakself = self else { return }
                weakself.hideActivityIndicator(uiView: weakself.view)
                if Helper.optionalIntToInt(value: model.status) == 200 {
                    weakself.showAlertWithOk(title: "Success", message: "Your profile pic is updated successfully")
                    weakself.getProfile()
                } else {
                    weakself.showAlertWithOk(title: "Error", message: "we encountered a problem with your request")
                }
            } failure: { [weak self] error in
                guard let weakself = self else { return }
                weakself.hideActivityIndicator(uiView: weakself.view)
                print(Helper.optionalStringToString(value: error?.msg))
            }
        } else {
           print("❌ Base64 error")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
   fileprivate func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func changePassword(_ password: String) {
        self.showActivityIndicator(uiView: self.view)
        let param: [String : Any] = ["newpassword": password, "repassword": password]
        APIManager.sharedInstance.changePassword(with: param) { [weak self] model in
            guard let weakself = self else { return }
            weakself.hideActivityIndicator(uiView: weakself.view)
            if Helper.optionalIntToInt(value: model.status) == 200 {
                weakself.showAlertWithOk(title: "Success", message: "Your password changed successefully.")
                weakself.profileTableView.reloadData()
            } else {
                weakself.showAlertWithOk(title: "Error", message: "we encountered a problem with your request")
            }
        } failure: { [weak self] error in
            guard let weakself = self else { return }
            weakself.hideActivityIndicator(uiView: weakself.view)
            print(Helper.optionalStringToString(value: error?.msg))
        }
    }
    
    
    fileprivate func passwordError(error: String) {
        showAlertWithOk(title: "Error", message: error)
    }
    
    
    fileprivate func deleteNumber(NumberID: Int) {
        let param: [String: Any] = ["data": NumberID]
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.deletePhone(with: param) { [weak self] model in
            guard let weakself = self else { return }
            weakself.hideActivityIndicator(uiView: weakself.view)
            if Helper.optionalIntToInt(value: model.status) == 200 {
                weakself.showAlertWithOk(title: "Success", message: "Successfully deleted your number")
                weakself.profileTableView.reloadData()
            } else {
                weakself.showAlertWithOk(title: "Error", message: "we encountered a problem with your request")
            }
        } failure: { [weak self] error in
            guard let weakself = self else { return }
            weakself.hideActivityIndicator(uiView: weakself.view)
            print(Helper.optionalStringToString(value: error?.msg))
        }

    }
    
    
    fileprivate func addPhoneNumber(number: String) {
        let param: [String : Any] = ["phone": number]
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.phoneAdd(with: param) { [weak self] model in
            guard let weakself = self else { return }
            weakself.hideActivityIndicator(uiView: weakself.view)
            weakself.phoneResponse = model
            if Helper.optionalIntToInt(value: model.status) == 200 {
                weakself.showOTPScreen()
            } else {
                weakself.showAlertWithOk(title: "Error", message: "Can't add your phone number, please try again.")
            }
        } failure: { [weak self] error in
            guard let weakself = self else { return }
            weakself.hideActivityIndicator(uiView: weakself.view)
            print(Helper.optionalStringToString(value: error?.msg))
        }

    }
    
    fileprivate func showOTPScreen() {
        let story = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = story.instantiateViewController(withIdentifier: "OtpPopUp") as? OtpPopUp else { return }
        vc.delegate = self
        vc.selector = phoneResponse?.selector
        vc.phone =  phoneResponse?.mobile
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension NewProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch options {
        case .profile:
            return 2
        case .phone:
            return 1
        case .password:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch options {
        case .profile:
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: profileIdentifier, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
                cell.nameTF.text = Helper.optionalStringToString(value: profileModel?.loggedUser?.name)
                cell.emailTF.text = Helper.optionalStringToString(value: profileModel?.loggedUser?.email)
                cell.profileImageView.sd_setImage(with: URL(string: GlobalConstantClass.APIConstantNames.imageBaseURL + Helper.optionalStringToString(value: profileModel?.loggedUser?.profile_image)))
                cell.changeProfile = changeProfilePic
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: socialMediaIdentifier, for: indexPath) as? ProfileSocialCell else { return UITableViewCell() }
                return cell
            }
        case .phone:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: phoneIdentifier, for: indexPath) as? ProfilePhoneCell else { return UITableViewCell() }
            cell.deletePhone = deleteNumber(NumberID:)
            cell.addPhoneNo = addPhoneNumber(number:)
            return cell
        case .password:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: passwordIdentifier, for: indexPath) as? PasswordChangeCell else { return UITableViewCell() }
            cell.passwordErrorMsg = passwordError(error:)
            cell.changePassword = changePassword(_:)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch options {
        case .profile:
            if indexPath.row == 0 {
                return 355
            } else {
                return 150
            }
        case .phone:
            return UITableView.automaticDimension
        case .password:
            return 280
        }
        
    }
    
}
