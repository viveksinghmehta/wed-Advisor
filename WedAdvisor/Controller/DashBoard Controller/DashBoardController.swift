//
//  DashBoardController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 21/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class DashBoardController: UIViewController {
    
    @IBOutlet weak var dashboardTbl: UITableView!
    
    
    let arrIcons = [UIImage(named: "ic_dashboard"), UIImage(named: "ic_heart"), UIImage(named: "ic_toDoList"), UIImage(named: "ic_budget"), UIImage(named: "ic_guestList"), UIImage(named: "ic_seatingTable"), UIImage(named: "ic_weddingWebsite"), UIImage(named: "ic_realWedding"), UIImage(named: "ic_myProfile.png"), UIImage(named: "ic_logout")]
    let arrayProfileName = ["Dashboard", "My Wishlist", "To Do List", "Budget", "GuestList", "SeatingTable", "Wedding Website", "Real Wedding", "My Profile", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        
    }
    
    // MARK:- Register cell
    func registerNibs(){
        let dasboard = UINib(nibName: "DashboardTableCell" , bundle: nil)
        dashboardTbl.register(dasboard, forCellReuseIdentifier: "DashboardTableCell")
        
    }
    
    @IBAction func backBtn(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension DashBoardController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dashboardTbl.dequeueReusableCell(withIdentifier: "DashboardTableCell", for: indexPath) as! DashboardTableCell
        cell.profileImg.image = arrIcons[indexPath.row]
        cell.profileNamesLbl.text = arrayProfileName[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let vc = storyboard?.instantiateViewController(withIdentifier: "CoupleDashboardController") as? CoupleDashboardController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 1{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ActivityOptionsController") as? ActivityOptionsController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 2{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ToDoListViewController") as? ToDoListViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 3{
            let vc = storyboard?.instantiateViewController(withIdentifier: "BudgetController") as? BudgetController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 4{
            let vc = storyboard?.instantiateViewController(withIdentifier: "GuestListController") as? GuestListController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 5{
            let vc = storyboard?.instantiateViewController(withIdentifier: "SeatingTableController") as? SeatingTableController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 6{
            let vc = storyboard?.instantiateViewController(withIdentifier: "WeddingWebsiteController") as? WeddingWebsiteController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 7{
            let vc = storyboard?.instantiateViewController(withIdentifier: "RealWeddingController") as? RealWeddingController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
            
        else if indexPath.row == 8{
            let vc = storyboard?.instantiateViewController(withIdentifier: "SelectOptionsController") as? SelectOptionsController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "LogoutController") as? LogoutController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
   
    }
 
}
