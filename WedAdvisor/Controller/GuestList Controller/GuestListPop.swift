//
//  GuestListPop.swift
//  WedAdvisor
//
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import DropDown


protocol dismissPopUp {
    func close(val : Bool)
}
class GuestListPop: UIViewController {

    @IBOutlet weak var viewRelation: UIView!
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var txtGuestName: UITextField!
    @IBOutlet weak var lblRelation: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var viewBack: UIView!
    
    var guestName : String?
    var relation : String?
    var email : String?
    var status : String?
    let dropDown = DropDown()
    let dropDownStatus = DropDown()
    var guestEditId : Int?
    var arrIdRelative = [1,2,3,4,5]
    var reltionId : Int?
    var statusId: Int?
    var delegateDis : dismissPopUp?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewRelation.layer.cornerRadius = 10
        viewStatus.layer.cornerRadius = 10
        viewStatus.layer.borderColor = UIColor.black.cgColor
        viewRelation.layer.borderColor = UIColor.black.cgColor
        viewStatus.layer.borderWidth = 1
        viewRelation.layer.borderWidth = 1
        btnEdit.layer.cornerRadius = 8
        txtGuestName.text = guestName
        lblRelation.text = relation
        txtEmail.text = email
        lblStatus.text = status
        viewBack.layer.cornerRadius = 10
        dropDown.anchorView = view // UIView or UIBarButtonItem

        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["Groom Sister", "Bride Friend", "Groom Friend", "Bride Family", "Groom Family"]
        dropDown.anchorView = viewRelation // UIView or UIBarButtonItem

        // The list of items to display. Can be changed dynamically
        dropDownStatus.dataSource = ["Completed", "Waiting", "Declined"]
        dropDownStatus.anchorView = viewStatus // UIView or UIBarButtonItem
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDown.hide()
            print("Selected item: \(item) at index: \(index)")
            self.reltionId = index+1
            self.lblRelation.text = item
        }
        
        
        dropDownStatus.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDownStatus.hide()
            print("Selected item: \(item) at index: \(index)")
            self.lblStatus.text = item
            self.statusId = index + 1
        }
    }
    
    //MARK:- VALIDATION
    func validation() -> Bool{
        if (txtEmail.text == ""){
            alertShow(msg: "Please enter Email")
            return false
        }
            
        else if (txtGuestName.text == ""){
            alertShow(msg: "Please enter Name!")
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


    @IBAction func btnEdit(_ sender: Any) {
        if validation(){
          editGuestList()
        }
    }
    
    @IBAction func btnStatus(_ sender: Any) {
        dropDownStatus.show()
        
    }
    @IBAction func btnRelation(_ sender: Any) {
        dropDown.show()
    }
    @IBAction func btnDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil
        )
    }
    
    
    func editGuestList()
    {
        let dictparam = ["guestid":  guestEditId ?? 0,
                         "guestname" : txtGuestName.text ?? "",
                         "relation" : reltionId ?? 0,
                         "email" : txtEmail.text ?? "",
                         "status" : statusId ?? 0] as [String:Any]
        
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.editGuest(with: dictparam, success: { (guestData) in
            self.hideActivityIndicator(uiView: self.view)
            if guestData.status == 200{
                let alert = UIAlertController(title: "", message: "Edit Successfully", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                // change to desired number of seconds (in this case 5 seconds)
                let when = DispatchTime.now() + 3
                DispatchQueue.main.asyncAfter(deadline: when){
                    // your code with delay
                    alert.dismiss(animated: true, completion: nil)
                }
                self.delegateDis?.close(val: true)
                self.dismiss(animated: true, completion: nil)
            }
        })
        { (error) in
            self.hideActivityIndicator(uiView: self.view)
        }
    }
}
