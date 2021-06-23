//
//  SideMenuVC.swift
//  Amfez
//
//  Created by Vishal Pandey on 10/12/20.
//  Copyright © 2020  Vishal Pandey. All rights reserved.
//

import UIKit

enum Menu {
    case Dashboard
    case Mywishlist
    case ToDoList
    case Budget
    case GuestList
    case SeatingTable
    case WeddingWebsite
    case RealWedding
    case MyProfile
    case Logout
    // case mywishlist
    case blank
    case faq
    case privacy
    case terms
    //    case download
    //    case downloadApple
}
protocol SideMenuDelegate {
    func sideMenu(didSelect menu: Menu)
}

protocol selectMenu {
    func selectMenuIndex(index: Int)
}

class SideMenuVC: UIViewController {
    
    @IBOutlet weak var tblMenu: UITableView!
    @IBOutlet weak var profileImg: UIImageView!
    
    private var menuArr: [Menu] = []
    var delegate: SideMenuDelegate?
    var onDidSelectItem: ((IndexPath) -> ())?
    var delegateMenu: selectMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenu.dataSource = self
        tblMenu.delegate = self
        menuArr = [.Dashboard, .Mywishlist, .ToDoList, .Budget , .GuestList, .SeatingTable,.WeddingWebsite,.RealWedding,.MyProfile,.Logout, .blank, .faq, .privacy, .terms]
    }
    
    
    @IBAction func btnDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //    @IBAction func profileBtnTapped(sender: UIButton){
    //        self.dismiss(animated: true, completion: nil)
    //
    //        self.delegateMenu?.selectMenuIndex(index: 100)
    //
    ////
    //    }
    
    
}

// MARK: - Helping Methods
extension SideMenuVC {
    
    private func getName(by menu: Menu) -> String {
        switch menu {
        case .Dashboard:
            return "Dashboard"
        case .Mywishlist:
            return "My Wishlist"
        case .ToDoList:
            return "To Do List"
        case .Budget:
            return "Budget"
        case .GuestList:
            return "Guest List"
        case .SeatingTable:
            return "Seating Table"
        case .WeddingWebsite:
            return "Wedding Website"
        case .RealWedding:
            return "Real Wedding"
        case .MyProfile:
            return "My Profile"
        case .Logout:
            return "Logout"
        case .blank:
            return ""
        case .faq:
            return "FAQs"
        case .privacy:
            return "Privacy Policy"
        case .terms:
            return "Terms & Conditions"
            //        case .download:
            //            return "Download"
            //        case .downloadApple:
            //            return "Download"
            
        }
    }
    //        private func getImage(by menu: Menu) -> UIImage? {
    //            switch menu {
    //            case .faq:
    //                return UIImage(named: "ic_FAQs")
    //            case .privacy:
    //                return UIImage(named: "ic_privacyPolicy")
    //            case .terms:
    //                return UIImage(named: "ic_Term&Condition")
    //            case .download:
    //                return UIImage(named: "ic_download")
    //            case .downloadApple:
    //                return UIImage(named: "ic_apple")
    //            default:
    //                return UIImage(named: "")
    //
    //            }
    //        }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8 || indexPath.row == 9{
           // cell.imgLogo.isHidden = true
            cell.imgArraow.isHidden = false
            cell.leadingConst.constant = -25
            cell.viewOuter.isHidden = true
            //   cell.topConst.constant = 12
            cell.lblMenu.font = cell.lblMenu.font.withSize(17)
        }
            //        else if indexPath.row == 7{
            //            cell.imgArraow.isHidden = true
            //
            //
            //        }
        else{
          //  cell.imgLogo.isHidden = false
            cell.imgArraow.isHidden = true
            cell.leadingConst.constant = -25
            cell.viewOuter.isHidden = true
            cell.lblMenu.font = cell.lblMenu.font.withSize(16)
            //       cell.topConst.constant = 12
            
            
            
        }
        cell.lblMenu.text = getName(by: menuArr[indexPath.row])
        //  cell.imgLogo.image = getImage(by: menuArr[indexPath.row])
        
        onDidSelectItem = {(indexPath) in
            print(indexPath.row)
            self.dismiss(animated: true, completion: nil)
            self.delegateMenu?.selectMenuIndex(index: indexPath.row)
        }
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 10 {
            return 20
        }
        else{
            return 38
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menu = menuArr[indexPath.row]
        self.onDidSelectItem?(indexPath)
    }
}
