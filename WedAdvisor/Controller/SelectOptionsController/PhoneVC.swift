//
//  PhoneVC.swift
//  WedAdvisor
//
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class PhoneVC: UIViewController, OTPDismiss {
    func dismissPop() {
        profileListData()
    }
    
    @IBOutlet weak var tblPhone: UITableView!
    @IBOutlet weak var heightPhone: NSLayoutConstraint!
    @IBOutlet weak var heightMain: NSLayoutConstraint!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtPhone: UITextField!
    var arrPhone : [usermobileInfo]?
    var idPhone : Int?


    override func viewDidLoad() {
        super.viewDidLoad()
        tblPhone.dataSource = self
        tblPhone.delegate = self
        btnSubmit.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileListData()
    }
    @IBAction func btnSubmit(_ sender: Any) {
        if txtPhone.text != ""{
           addPhone()
        }
        else{
            alertShow(msg: "Please enter Phone Number")
        }
    }

    
    func connfigTableHeight(){
       
        if arrPhone?.count == 0{
            tblPhone.isHidden = true
            let numberOfLines = arrPhone?.count ?? 0
            heightMain.constant = 190
            heightPhone.constant = CGFloat(50*numberOfLines)
            tblPhone.reloadData()
        }
        else{
            tblPhone.isHidden = false
            let numberOfLines = arrPhone?.count ?? 0/1+1
            heightMain.constant = CGFloat(200*numberOfLines)
            heightPhone.constant = CGFloat(50*numberOfLines)
            tblPhone.reloadData()
        }
    }

}
extension PhoneVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPhone?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneCell", for: indexPath) as! PhoneCell
        let phone = arrPhone?[indexPath.row]
        cell.lblPhone.text = phone?.mobile
        cell.removeClosure = {
            self.idPhone = phone?.id
            self.deletePhone()
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
extension PhoneVC{
    func profileListData()
    {
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.MyProfile(success: { (myProfileData) in
            self.hideActivityIndicator(uiView: self.view)
            self.arrPhone = myProfileData.usermobile
            self.connfigTableHeight()
        })
            
        { (error) in
            self.hideActivityIndicator(uiView: self.view)
        }
    }

    
    func addPhone()
    {
        let dictparam = ["phone": txtPhone.text ?? 0] as [String:Any]
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.phoneAdd(with: dictparam, success: { (todoadd) in
            self.hideActivityIndicator(uiView: self.view)
            print(todoadd)
            if todoadd.status == 200{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpPopUp") as? OtpPopUp
//                vc?.delegatedismiss = self
                vc?.selector = todoadd.selector
                vc?.phone =  self.txtPhone.text
                self.navigationController?.present(vc!, animated: true, completion: nil)
            }
            else if todoadd.status == 300{
                self.alertShow(msg: "Phone Number Already Added")
            }
        }){ (error) in
            self.hideActivityIndicator(uiView: self.view)
        }
    }
    
    func deletePhone()
    {
        let dictparam = ["data": idPhone ?? 0] as [String:Any]
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.deletePhone(with: dictparam, success: { (todoadd) in
            self.hideActivityIndicator(uiView: self.view)
            print(todoadd)
            if todoadd.status == 200{
                self.alertShow(msg: "Phone Number Deleted Successfully")
                self.profileListData()
            }
            else if todoadd.status == 300{
                self.alertShow(msg: "Phone Number Already Added")
            }
        }){ (error) in
            self.hideActivityIndicator(uiView: self.view)
        }
    }
    
      func alertShow(msg : String){
    self.present(UIAlertController.alertWithTitle(title: "", message: msg , buttonTitle: "OK"), animated: true, completion: nil)
      }
}
