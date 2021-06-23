//
//  GuestListController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 25/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class GuestListController: UIViewController, dismissPopUp  {
    func close(val: Bool) {
        guestList()
        guestListDetail()
    }
    
    
    @IBOutlet weak var guestInfoLbl: UILabel!
    @IBOutlet weak var guestCountLbl: UILabel!
    @IBOutlet weak var accpetedCountLbl: UILabel!
    @IBOutlet weak var waitingCountLbl: UILabel!
    @IBOutlet weak var declinedCountLbl: UILabel!
    @IBOutlet weak var guestListTbl: UITableView!
    @IBOutlet weak var btnAddNewGuest: UIButton!
    @IBOutlet weak var allGuestCountLbl: UILabel!
    @IBOutlet weak var completedLbl: UILabel!
    @IBOutlet weak var waitingLbl: UILabel!
    @IBOutlet weak var declinedLbl: UILabel!
    @IBOutlet weak var singleSelectView: UIView!
    @IBOutlet weak var singleCountLbl: UILabel!
    @IBOutlet weak var coupleSelectView: UIView!
    @IBOutlet weak var couplesCountLbl: UILabel!
    @IBOutlet weak var householdSelectView: UIView!
    @IBOutlet weak var householdCountLbl: UILabel!
    @IBOutlet weak var viewLists: UIView!
    @IBOutlet weak var viewAllGuest: UIView!
    @IBOutlet weak var viewCompleted: UIView!
    @IBOutlet weak var viewSelection: UIView!
    @IBOutlet weak var viewWaiting: UIView!
    @IBOutlet weak var viewDecline: UIView!
    @IBOutlet weak var lblComplete: UILabel!
    @IBOutlet weak var lblWaiting: UILabel!
    @IBOutlet weak var lblDeclined: UILabel!
    @IBOutlet weak var lblGuest: UILabel!
    
    @IBOutlet weak var lblCompleteLead: NSLayoutConstraint!
    @IBOutlet weak var lblCompleteTrail: NSLayoutConstraint!
    @IBOutlet weak var lblWaitLead: NSLayoutConstraint!
    @IBOutlet weak var lblWaitTrailing: NSLayoutConstraint!
    @IBOutlet weak var lblDeclineLead: NSLayoutConstraint!
    @IBOutlet weak var lblDeclineTrail: NSLayoutConstraint!
    @IBOutlet weak var lblAll: UILabel!
    @IBOutlet weak var lblAccept: UILabel!
    @IBOutlet weak var lblWait: UILabel!
    @IBOutlet weak var lblDecline: UILabel!
    @IBOutlet weak var heightTable: NSLayoutConstraint!
    @IBOutlet weak var scrOption: UIScrollView!
    
    var isSingle: Bool = true
    var isCouples: Bool = true
    var isHousehold: Bool = true
    var arrDetails : [GuestDetail]?
    var status : Int?
    var type : String?
    var guestId : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        design()
        guestListTbl.addRightBorder(with: .darkGray, andWidth: 0.5)
        guestListTbl.addLeftBorder(with: .darkGray, andWidth: 0.5)
        guestListTbl.addBottomBorder(with: .darkGray, andWidth: 0.5)
        viewSelection.addRightBorder(with: .darkGray, andWidth: 0.5)
        viewSelection.addLeftBorder(with: .darkGray, andWidth: 0.5)
        viewAllGuest.layer.cornerRadius = 7
        viewCompleted.layer.cornerRadius = 7
        viewWaiting.layer.cornerRadius = 7
        viewDecline.layer.cornerRadius = 7
        viewAllGuest.layer.borderColor = UIColor.darkGray.cgColor
        viewAllGuest.layer.borderWidth = 1
        viewCompleted.addBottomBorder(with: .darkGray, andWidth: 0.5)
        viewWaiting.addBottomBorder(with: .darkGray, andWidth: 0.5)
        viewDecline.addBottomBorder(with: .darkGray, andWidth: 0.5)
        lblGuest.isHidden = true
        allGuestCountLbl.textColor = .red
        completedLbl.textColor = .black
        waitingLbl.textColor = .black
        declinedLbl.textColor = .black
    }
    override func viewWillAppear(_ animated: Bool) {
        guestList()
        guestListDetail()
    }
    
    // MARK:- Register cell
    func registerNibs(){
        let singleGuestNib = UINib(nibName: "SingleGuestListCell" , bundle: nil)
        guestListTbl.register(singleGuestNib, forCellReuseIdentifier: "SingleGuestListCell")
        let coupleGuestNib = UINib(nibName: "CoupleGuestListCell" , bundle: nil)
        guestListTbl.register(coupleGuestNib, forCellReuseIdentifier: "CoupleGuestListCell")
        
    }
    
    func design(){
        isSingle = true
        isCouples = false
        isHousehold = false
        singleCoupleHouseholdSelectionChange()
    }
    
    func connfigTableHeight(){
        if arrDetails?.count == 0{
            let numberOfLines = arrDetails?.count ?? 0
            heightTable.constant = CGFloat(0*numberOfLines)
            scrOption.isHidden = false
            viewSelection.isHidden = false
            guestListTbl.reloadData()
        }
        else{
            let numberOfLines = arrDetails?.count ?? 0/1+1
            heightTable.constant = CGFloat(290*numberOfLines)
            scrOption.isHidden = false
            viewSelection.isHidden = false
            guestListTbl.reloadData()
        }
    }
    
    @IBAction func backBtn(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func allGuestBtnTapped(sender: UIButton){
        viewAllGuest.layer.borderColor = UIColor.darkGray.cgColor
        viewAllGuest.layer.borderWidth = 0.5
        lblWaiting.isHidden = false
        lblDeclined.isHidden = false
        lblGuest.isHidden = true
        lblComplete.isHidden = false
        viewCompleted.layer.borderColor = UIColor.white.cgColor
        viewCompleted.layer.borderWidth = 0
        viewWaiting.layer.borderColor = UIColor.white.cgColor
        viewWaiting.layer.borderWidth = 0
        viewDecline.layer.borderColor = UIColor.white.cgColor
        viewDecline.layer.borderWidth = 0
        lblWaiting.isHidden = false
        status = 0
        allGuestCountLbl.textColor = .red
        completedLbl.textColor = .black
        waitingLbl.textColor = .black
        declinedLbl.textColor = .black
        guestList()
        guestListDetail()
    }
    
    @IBAction func completedBtnTapped(sender: UIButton){
        viewAllGuest.layer.borderColor = UIColor.white.cgColor
        viewAllGuest.layer.borderWidth = 0
        viewCompleted.layer.borderColor = UIColor.darkGray.cgColor
        viewCompleted.layer.borderWidth = 0.5
        lblComplete.isHidden = true
        lblGuest.isHidden = false
        viewWaiting.layer.borderColor = UIColor.white.cgColor
        viewWaiting.layer.borderWidth = 0
        viewDecline.layer.borderColor = UIColor.white.cgColor
        viewDecline.layer.borderWidth = 0
        lblWaiting.isHidden = false
        lblDeclined.isHidden = false
        status = 1
        allGuestCountLbl.textColor = .black
        completedLbl.textColor = .red
        waitingLbl.textColor = .black
        declinedLbl.textColor = .black
        guestList()
        guestListDetail()
        
    }
    
    @IBAction func waitingBtnTapped(sender: UIButton){
        viewAllGuest.layer.borderColor = UIColor.white.cgColor
        viewAllGuest.layer.borderWidth = 0
        viewCompleted.layer.borderColor = UIColor.white.cgColor
        viewCompleted.layer.borderWidth = 0
        viewWaiting.layer.borderColor = UIColor.darkGray.cgColor
        viewWaiting.layer.borderWidth = 0.5
        viewDecline.layer.borderColor = UIColor.white.cgColor
        viewDecline.layer.borderWidth = 0
        lblComplete.isHidden = false
        lblGuest.isHidden = false
        lblWaiting.isHidden = true
        lblDeclined.isHidden = false
        status = 2
        allGuestCountLbl.textColor = .black
        completedLbl.textColor = .black
        waitingLbl.textColor = .red
        declinedLbl.textColor = .black
        guestList()
        guestListDetail()
    }
    
    @IBAction func declinedBtnTapped(sender: UIButton){
        viewAllGuest.layer.borderColor = UIColor.white.cgColor
        viewAllGuest.layer.borderWidth = 0
        viewCompleted.layer.borderColor = UIColor.white.cgColor
        viewCompleted.layer.borderWidth = 0
        viewWaiting.layer.borderColor = UIColor.white.cgColor
        viewWaiting.layer.borderWidth = 0
        viewDecline.layer.borderColor = UIColor.darkGray.cgColor
        viewDecline.layer.borderWidth = 1
        lblComplete.isHidden = false
        lblGuest.isHidden = false
        lblWaiting.isHidden = false
        lblDeclined.isHidden = true
        status = 3
        allGuestCountLbl.textColor = .black
        completedLbl.textColor = .black
        waitingLbl.textColor = .black
        declinedLbl.textColor = .red
        guestList()
        guestListDetail()
    }
    
    @IBAction func singleBtnTapped(sender: UIButton){
        isSingle = true
        isCouples = false
        isHousehold = false
        singleCoupleHouseholdSelectionChange()
        type = "single"
        guestListDetail()
    }
    
    @IBAction func couplesBtnTapped(sender: UIButton){
        isSingle = false
        isCouples = true
        isHousehold = false
        singleCoupleHouseholdSelectionChange()
        type = "couple"
        guestListDetail()
    }
    
    @IBAction func householdBtnTapped(sender: UIButton){
        isSingle = false
        isCouples = false
        isHousehold = true
        singleCoupleHouseholdSelectionChange()
        type = "house"
        guestListDetail()
    }
    
    @IBAction func btnAddGuest(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SingleGuestController") as? SingleGuestController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func singleCoupleHouseholdSelectionChange(){
        
        if isSingle{
            singleSelectView.layer.backgroundColor = WedAdviserColor.buttonselectBackgroundColor().cgColor
            singleCountLbl.textColor = UIColor.white
            coupleSelectView.layer.backgroundColor = UIColor.white.cgColor
            couplesCountLbl.textColor = WedAdviserColor.buttonselectBackgroundColor()
            householdSelectView.layer.backgroundColor = UIColor.white.cgColor
            householdCountLbl.textColor = WedAdviserColor.buttonselectBackgroundColor()
        }else if isCouples{
            
            singleSelectView.layer.backgroundColor = UIColor.white.cgColor
            singleCountLbl.textColor = WedAdviserColor.buttonselectBackgroundColor()
            coupleSelectView.layer.backgroundColor = WedAdviserColor.buttonselectBackgroundColor().cgColor
            couplesCountLbl.textColor = UIColor.white
            householdSelectView.layer.backgroundColor = UIColor.white.cgColor
            householdCountLbl.textColor = WedAdviserColor.buttonselectBackgroundColor()
            
        }else{
            singleSelectView.layer.backgroundColor =  UIColor.white.cgColor
            singleCountLbl.textColor =  WedAdviserColor.buttonselectBackgroundColor()
            coupleSelectView.layer.backgroundColor = UIColor.white.cgColor
            couplesCountLbl.textColor = WedAdviserColor.buttonselectBackgroundColor()
            householdSelectView.layer.backgroundColor = WedAdviserColor.buttonselectBackgroundColor().cgColor
            householdCountLbl.textColor = UIColor.white
        }
        
    }
    
    
    
}

extension GuestListController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = guestListTbl.dequeueReusableCell(withIdentifier: "SingleGuestListCell", for: indexPath)as? SingleGuestListCell
        
        let dict = arrDetails?[indexPath.row]
        cell?.lblGuestName.text = dict?.guest_one
        cell?.lblEmail.text = dict?.email
        cell?.lblrelation.text = dict?.relation?.name
        cell?.lblStatus.text = dict?.gueststatus?.status_name
        cell?.ViewDeleteClosure={
            self.guestId = dict?.id
            self.deleteGuestList()
        }
        cell?.ViewEditClosure = {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GuestListPop") as? GuestListPop
            let dict = self.arrDetails?[indexPath.row]
            vc?.guestName = cell?.lblGuestName.text
            vc?.relation = cell?.lblrelation.text
            vc?.email = cell?.lblEmail.text
            vc?.status = cell?.lblStatus.text
            vc?.guestEditId = dict?.id
            vc?.statusId = dict?.gueststatus?.id
            vc?.reltionId = dict?.relation?.id
            vc?.delegateDis = self
            self.navigationController?.present(vc!, animated: true, completion: nil)
        }
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
    
}

extension GuestListController{
    func guestList()
    {
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.guestList(success: { (todoData) in
            self.hideActivityIndicator(uiView: self.view)
            if let completed = todoData.allguest?.all{
                self.lblAll.text = "\(completed)"
                self.allGuestCountLbl.text = "All Guest (\(completed))"
            }
            if let duetask = todoData.completedguest?.all{
                self.lblAccept.text = "\(duetask)"
                self.completedLbl.text = "Completed (\(duetask))"
            }
            if let waiting = todoData.waitingguest?.all{
                self.lblWait.text = "\(waiting)"
                self.waitingLbl.text = "Waiting (\(waiting))"
                
            }
            if let total = todoData.declineguest?.all{
                self.lblDecline.text = "\(total)"
                self.declinedLbl.text = "Declined(\(total))"
            }
            
            if self.status == 0{
                if let single = todoData.allguest?.single{
                    self.singleCountLbl.text = "Single (\(single))"
                }
                
                if let couple = todoData.allguest?.couple{
                    self.couplesCountLbl.text = "Couples (\(couple))"
                }
                
                if let houseHold = todoData.allguest?.household{
                    self.householdCountLbl.text = "Household (\(houseHold))"
                }
            }
                
            else if self.status == 1{
                if let single = todoData.completedguest?.single{
                    self.singleCountLbl.text = "Single (\(single))"
                }
                
                if let couple = todoData.completedguest?.couple{
                    self.couplesCountLbl.text = "Couples (\(couple))"
                }
                
                if let houseHold = todoData.completedguest?.household{
                    self.householdCountLbl.text = "Household (\(houseHold))"
                }
            }
                
                
            else if self.status == 2{
                if let single = todoData.waitingguest?.single{
                    self.singleCountLbl.text = "Single (\(single))"
                }
                
                if let couple = todoData.waitingguest?.couple{
                    self.couplesCountLbl.text = "Couples (\(couple))"
                }
                
                if let houseHold = todoData.waitingguest?.household{
                    self.householdCountLbl.text = "Household (\(houseHold))"
                }
            }
                
            else if self.status == 3{
                
                if let single = todoData.declineguest?.single{
                    self.singleCountLbl.text = "Single (\(single))"
                }
                
                if let couple = todoData.declineguest?.couple{
                    self.couplesCountLbl.text = "Couples (\(couple))"
                }
                
                if let houseHold = todoData.declineguest?.household{
                    self.householdCountLbl.text = "Household (\(houseHold))"
                }
            }
            else{
                if let single = todoData.allguest?.single{
                    self.singleCountLbl.text = "Single (\(single))"
                }
                
                if let couple = todoData.allguest?.couple{
                    self.couplesCountLbl.text = "Couples (\(couple))"
                }
                
                if let houseHold = todoData.allguest?.household{
                    self.householdCountLbl.text = "Household (\(houseHold))"
                }
            }
            
        })
            
        { (error) in
            self.hideActivityIndicator(uiView: self.view)
        }
    }
    
    
    func guestListDetail()
    {
        let dictparam = ["status": status ?? 0,
                         "type": type ?? ""] as [String:Any]
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.guestListDetail(with: dictparam, success: { (guestData) in
            self.hideActivityIndicator(uiView: self.view)
            self.arrDetails = guestData.guest?.data
            self.connfigTableHeight()
            //self.guestListTbl.reloadData()
        })
        { (error) in
            self.hideActivityIndicator(uiView: self.view)
        }
    }
    
    
    func deleteGuestList()
    {
        let dictparam = ["guestid": guestId ?? 0] as [String:Any]
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.deleteGuest(with: dictparam, success: { (guestData) in
            self.hideActivityIndicator(uiView: self.view)
            if guestData.status == 200{
                let alert = UIAlertController(title: "", message: "Guest Deleted Successfully", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                // change to desired number of seconds (in this case 5 seconds)
                let when = DispatchTime.now() + 3
                DispatchQueue.main.asyncAfter(deadline: when){
                    // your code with delay
                    alert.dismiss(animated: true, completion: nil)
                    self.guestList()
                    self.guestListDetail()
                }
            }
        })
        { (error) in
            self.hideActivityIndicator(uiView: self.view)
        }
    }
}
