//
//  SideMenuController.swift
//  WedAdvisor
//
//  Created by WishACloud on 24/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import SDWebImage
import DefaultsKit


enum SideMenuOptions {
    case dashboard
    case mywishlist
    case todolist
    case budget
    case guestlist
    case seatingtable
    case myprofile
    case logout
    case aboutus
    case ourteam
    case privacy
    case terms
    case none
}

protocol SideMenuControllerDelegate: NSObject {
   func didSelectMenuOption(menu: SideMenuOptions)
}

class SideMenuController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sideTableView: UITableView!
    
    struct SideMenuData {
        var title: String
        var showSeperator: Bool
        var showImage: Bool
        var menu: SideMenuOptions
    }

    private let sideMenuArray: [SideMenuData] =
        [
            SideMenuData(title: "Dashboard", showSeperator: false, showImage: true, menu: .dashboard),
            SideMenuData(title: "My Wishlist", showSeperator: false, showImage: true, menu: .mywishlist),
            SideMenuData(title: "To Do List", showSeperator: false, showImage: true, menu: .todolist),
            SideMenuData(title: "Budget", showSeperator: false, showImage: true, menu: .budget),
            SideMenuData(title: "Guest List", showSeperator: false, showImage: true, menu: .guestlist),
            SideMenuData(title: "Seating Table", showSeperator: false, showImage: true, menu: .seatingtable),
            SideMenuData(title: "My Profile", showSeperator: false, showImage: true, menu: .myprofile),
            SideMenuData(title: "Logout", showSeperator: false, showImage: true, menu: .logout),
            SideMenuData(title: "", showSeperator: true, showImage: false, menu: .none),
            SideMenuData(title: "ABOUT US", showSeperator: false, showImage: false, menu: .aboutus),
            SideMenuData(title: "OUR TEAM", showSeperator: false, showImage: false, menu: .ourteam),
            SideMenuData(title: "PRIVACY POLICY", showSeperator: false, showImage: false, menu: .privacy),
            SideMenuData(title: "TERMS & CONDITIONS", showSeperator: false, showImage: false, menu: .terms)
        ]
    
    // seperator after logout
    private let sideMenuIdentifier: String = "sidemenucell"
    private let seperatorIdentifier: String = "seperatorcell"
    
    weak var delegate: SideMenuControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIChanges()
        tableviewInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showUsersData()
    }
    
    
    fileprivate func showUsersData() {
        if let profile = Defaults().get(for: .profile) {
            nameLabel.text = Helper.optionalStringToString(value: profile.loggedUser?.name)
            profileImageView.sd_setImage(with: URL(string: GlobalConstantClass.APIConstantNames.imageBaseURL  + Helper.optionalStringToString(value: profile.loggedUser?.profile_image)))
        } else {
            nameLabel.text = "User"
        }
    }
    
    
    
    fileprivate func UIChanges() {
        profileImageView.makeRounded(cornerRadius: ((UIScreen.main.bounds.height * 0.13) - 20) / 2, color: .white, width: 3)
    }
    
    
    fileprivate func tableviewInit() {
        sideTableView.delegate = self
        sideTableView.dataSource = self
        sideTableView.register(UINib(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: sideMenuIdentifier)
        sideTableView.register(UINib(nibName: "SeperatorCell", bundle: nil), forCellReuseIdentifier: seperatorIdentifier)
        sideTableView.tableFooterView = UIView()
        sideTableView.backgroundColor = WedAdviserColor.themeOrangeColor()
    }


    

}

extension SideMenuController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if sideMenuArray[indexPath.row].showSeperator {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: seperatorIdentifier, for: indexPath) as? SeperatorCell else { return UITableViewCell() }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: sideMenuIdentifier, for: indexPath) as? SideMenuCell else { return UITableViewCell() }
            cell.menuLabel.text = sideMenuArray[indexPath.row].title
            if sideMenuArray[indexPath.row].showImage {
                cell.rightImage.isHidden = false
                cell.menuLabel.font = UIFont(name: "ProductSans-Regular", size: 17)
            } else {
                cell.rightImage.isHidden = true
                cell.menuLabel.font = UIFont(name: "ProductSans-Regular", size: 14)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !sideMenuArray[indexPath.row].showSeperator {
            delegate?.didSelectMenuOption(menu: sideMenuArray[indexPath.row].menu)
        }
    }
    
    
}
