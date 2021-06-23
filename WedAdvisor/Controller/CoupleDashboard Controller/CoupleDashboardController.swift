//
//  CoupleDashboardController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 27/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class CoupleDashboardController: UIViewController {
    
    var arrType = [[String: Any]]()
    var complete : String?
    var remain : String?
    var accept : String?
    var dec : String?
    
    @IBOutlet weak var coupleDashBoardTbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DashboardData()
    }
    
    @IBAction func backBtn(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension CoupleDashboardController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoupleDashboardCell", for: indexPath) as? CoupleDashboardCell else { return UITableViewCell() }
        
        cell.lblName.text = arrType[indexPath.row]["name"] as? String
        cell.lblNumber.text = Helper.optionalIntToString(value: arrType[indexPath.row]["key"] as? Int)
        
        switch indexPath.row {
        case 0:
            cell.bgView.layer.backgroundColor = WedAdviserColor.firstRowBackgroundColor().cgColor
            cell.lblCompare.text = "Compare & Finalize"
        case 1:
            cell.bgView.layer.backgroundColor = WedAdviserColor.secondRowBackgroundColor().cgColor
            cell.lblCompare.text = "\(complete ?? "0") Complete \(remain ?? "0") Remain"
        case 2:
            cell.bgView.layer.backgroundColor = WedAdviserColor.thirdRowBackgroundColor().cgColor
            cell.lblCompare.text = "\(accept ?? "0") Accepted \(dec ?? "0") Declined"
        case 3:
            cell.bgView.layer.backgroundColor = WedAdviserColor.forthRowBackgroundColor().cgColor
            cell.lblCompare.text = ""
        case 4:
            cell.bgView.layer.backgroundColor = WedAdviserColor.firstRowBackgroundColor().cgColor
            cell.lblCompare.text = ""
         default:
            break
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier: "MyWishListController") as? MyWishListController
            self.navigationController?.pushViewController(vc!, animated: true)
        case 1:
            let vc = storyboard?.instantiateViewController(withIdentifier: "ToDoListViewController") as? ToDoListViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        case 2:
            let vc = storyboard?.instantiateViewController(withIdentifier: "GuestListController") as? GuestListController
            self.navigationController?.pushViewController(vc!, animated: true)
        case 3:
            let vc = storyboard?.instantiateViewController(withIdentifier: "SeatingTableController") as? SeatingTableController
            self.navigationController?.pushViewController(vc!, animated: true)
        case 6:
            let vc = storyboard?.instantiateViewController(withIdentifier: "BudgetController") as? BudgetController
            self.navigationController?.pushViewController(vc!, animated: true)
        default :
            break
        }
//        if indexPath.row == 0 {
//
//        }
//        if indexPath.row == 1 {
//
//        }
//        if indexPath.row == 2 {
//
//        }
//        if indexPath.row == 3{
//
//        }
//        if indexPath.row == 6{
//
//        }
        
    }
    
}
extension CoupleDashboardController{
    func DashboardData()
    {
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.dashboardData(success: { (dashBoardData) in
            self.hideActivityIndicator(uiView: self.view)
            if let wishlistVendors = dashBoardData.wishlistVendors{
                self.arrType.append(["name":"Vendors Wishlist", "key": wishlistVendors])
            }
            if let totaltask = dashBoardData.totaltask{
                self.arrType.append(["name":"Total To Do", "key": totaltask])
                
            }
            if let allGuests = dashBoardData.allGuests{
                self.arrType.append(["name":"Guest Lists", "key": allGuests])
                
            }
            if let seatingtable = dashBoardData.seatingtable{
                self.arrType.append(["name":"Table Seating", "key": seatingtable])
                
            }
            if let budgetsum = dashBoardData.budgetsum{
                self.arrType.append(["name":"Budget", "key": budgetsum])
                
            }
            if let comp = dashBoardData.completedtask{
                self.complete = "\(comp)"
            }
            if let rem = dashBoardData.pendingtask{
                self.remain = "\(rem)"
            }
            if let accept = dashBoardData.guestaccepted{
                self.accept = "\(accept)"
            }
            if let dec = dashBoardData.guestdeclined{
                self.dec = "\(dec)"
            }
            print(self.arrType)
            self.coupleDashBoardTbl.reloadData()
            
        })
            
        { (error) in
            self.hideActivityIndicator(uiView: self.view)
            
            
        }
    }
}
