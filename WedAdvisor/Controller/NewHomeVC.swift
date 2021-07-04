//
//  NewHomeVC.swift
//  WedAdvisor
//

//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import SideMenu
import DefaultsKit

final class NewHomeVC: UIViewController, selectMenu, nextVC, wishList {
    func wishList(value: Bool) {
        checkfromwish = true
    }
    
    func getCell(index: Int, id: Int) {
        if index == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VendorProductDetailController") as? VendorProductDetailController
            vc?.vendorId = id
            self.navigationController?.pushViewController(vc!, animated: true)
        } else if index == 2 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllVendorsController") as? AllVendorsController
            self.navigationController?.pushViewController(vc!, animated: true)
        } else if index == 5 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "VendorFilterVC") as? VendorFilterVC
            vc?.vendorType = id
            self.navigationController?.pushViewController(vc!, animated: true)
        } else if index == 6 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "BlogDetailController") as? BlogDetailController
            vc?.id = id
            vc?.checkfromHome = true
            self.navigationController?.pushViewController(vc!, animated: true)
        } else if index == 4 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "VendorFilterVC") as? VendorFilterVC
            vc?.vendorType = id
            vc?.checkforLocation =  true
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    
    func selectMenuIndex(index: Int) {
        nextMenu(indexMenu: index)
    }
    
    @IBOutlet weak var tblHome: UITableView!
    
    
    @IBOutlet weak var chooseLocationLabel: UILabel!
    var arrHomeDetail : [HomeDetail]?
    var arrTitle = [String]()
    var arrItemList : [HomeItemList]?
    var arrPopularCat : [HomeVendorType]?
    var arrLatestWed : [HomeItemList]?
    var arrPopularLoc : [GetLocation]?
    var arrHowItWork : [GetHowWork]?
    var arrTestimonial : [GetTestimonial]?
    var arrGetWedding : [GetweddTipsNews]?
    var changeHeader : String?
    var arrSendLoc : [HomeLocation]?
    var checkfromwish : Bool?
    
    
    //MARK:- Identifiers
    private let vendorsIdentifiers: String = "vendorCollectionCell"
    private let sildeShowIdentifier: String = "HomeSliderCell"
    private let popularLocationsIdentifier: String = "popularLocationDashboard"
    private let popularCategoriesIdentifier: String = "popularCategories"
    private let weddingIdentifier: String = "weddingTipsCell"
    private let testimonialIdenitifier: String = "testimonialDashboardCell"
    private var sideMenu: SideMenuNavigationController!
    //MARK:- NewVariables
    var dashboardArray = [HomeDetail?]()
    var bannerData = [HomeBanner]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        addSideMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLocation()
        homeData()
    }
    
    
    fileprivate func setLocation() {
        if let location = Defaults().get(for: .location) {
            self.chooseLocationLabel.text = Helper.optionalStringToString(value: location.city).capitalizingFirstLetter()
        }
    }
    
    
    fileprivate func addSideMenu() {
        let sideMenuController = SideMenuController()
        sideMenuController.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: sideMenuController)
        sideMenu.enableSwipeToDismissGesture = true
        sideMenu.leftSide = true
        sideMenu.presentationStyle = .menuSlideIn
        sideMenu.menuWidth = UIScreen.main.bounds.width * 0.7
        sideMenu.navigationBar.isHidden = true
    }
    
    // MARK:- Register cell
    fileprivate func registerNibs() {
        tblHome.register(UINib(nibName: "HomeSliderCell" , bundle: nil), forCellReuseIdentifier: sildeShowIdentifier)
        tblHome.register(UINib(nibName: "VendorsCollectionCell" , bundle: nil), forCellReuseIdentifier: vendorsIdentifiers)
        tblHome.register(UINib(nibName: "PopularLocationsDashboardCell", bundle: nil), forCellReuseIdentifier: popularLocationsIdentifier)
        tblHome.register(UINib(nibName: "PopularCategoriesDashboardCell", bundle: nil), forCellReuseIdentifier: popularCategoriesIdentifier)
        tblHome.register(UINib(nibName: "WeddingTippsCell", bundle: nil), forCellReuseIdentifier: weddingIdentifier)
        tblHome.register(UINib(nibName: "TestimonialDashboardCell", bundle: nil), forCellReuseIdentifier: testimonialIdenitifier)
        tblHome.dataSource = self
        tblHome.delegate = self
    }
    
    @IBAction func btnMenu(_ sender: Any) {
        self.tabBarController?.present(sideMenu, animated: true, completion: nil)
    }
    
    
    @IBAction func btnProfile(_ sender: Any) {
        let profile = NewProfileViewController()
        self.tabBarController?.navigationController?.pushViewController(profile, animated: true)
//        let vc = storyboard?.instantiateViewController(withIdentifier: "SelectOptionsController") as? SelectOptionsController
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func changeLocation(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "LocationController") as? LocationController else { return }
        vc.delegate = self
        vc.arrPopularLoc = arrSendLoc
        vc.arrPopularLocNew = arrSendLoc
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        let searchController = SearchController()
        present(searchController, animated: true, completion: nil)
    }
    
}

extension NewHomeVC: PopularLocationDelegate, PopularCategoryDelegate, VendorDelegate, WeddingTipsDelegate, LocationDelegate, SideMenuControllerDelegate {
    
    
    func didSelectMenuOption(menu: SideMenuOptions) {
        switch menu {
        case .dashboard:
            sideMenu.dismiss(animated: true, completion: nil)
            let vc = storyboard?.instantiateViewController(withIdentifier: "CoupleDashboardController") as! CoupleDashboardController
            self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        case .mywishlist:
            sideMenu.dismiss(animated: true, completion: nil)
            let vc = storyboard?.instantiateViewController(withIdentifier: "MyWishListController") as! MyWishListController
            self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        case .todolist:
            sideMenu.dismiss(animated: true, completion: nil)
            let vc = storyboard?.instantiateViewController(withIdentifier: "ToDoListViewController") as! ToDoListViewController
            self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        case .budget:
            sideMenu.dismiss(animated: true, completion: nil)
            let vc = storyboard?.instantiateViewController(withIdentifier: "BudgetController") as! BudgetController
            self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        case .guestlist:
            sideMenu.dismiss(animated: true, completion: nil)
            let vc = storyboard?.instantiateViewController(withIdentifier: "GuestListController") as! GuestListController
            self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        case .seatingtable:
            sideMenu.dismiss(animated: true, completion: nil)
            let vc = storyboard?.instantiateViewController(withIdentifier: "SeatingTableController") as! SeatingTableController
            self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        case .myprofile:
            sideMenu.dismiss(animated: true, completion: nil)
            let vc = storyboard?.instantiateViewController(withIdentifier: "SelectOptionsController") as! SelectOptionsController
            self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        case .logout:
            sideMenu.dismiss(animated: true, completion: nil)
            let vc = storyboard?.instantiateViewController(withIdentifier: "LogoutController") as! LogoutController
            self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        case .aboutus:
            sideMenu.dismiss(animated: true, completion: nil)
        case .ourteam:
            sideMenu.dismiss(animated: true, completion: nil)
        case .privacy:
            sideMenu.dismiss(animated: true, completion: nil)
        case .terms:
            sideMenu.dismiss(animated: true, completion: nil)
        case .none:
            break
        }
    }
    
    func moreWeddingTips() {
        self.tabBarController?.selectedIndex = 4
    }
    
    
    func locationSelected(city: String) {
        self.chooseLocationLabel.text = city.capitalizingFirstLetter()
    }
    
    
    func categorySelected(selected: Int, IndexPath: IndexPath) {
        if selected == 5 {
            self.tabBarController?.selectedIndex = 1
        } else {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "VendorFilterVC") as? VendorFilterVC else { return }
            vc.vendorType = dashboardArray[IndexPath.row - 1]?.vendor_type?[selected].id
            self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func vendorSelected(selcted: Int, indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "VendorProductDetailController") as? VendorProductDetailController else { return }
        vc.vendorId = dashboardArray[indexPath.row - 1]?.itemlist?[selcted].id
        self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func weddingTipSelected(selected: Int, indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "BlogDetailController") as? BlogDetailController else { return }
        vc.id = dashboardArray[indexPath.row - 1]?.weddTipsNews?[selected].id
        vc.checkfromHome = true
        self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func popularLocationSelected(selected: Int, indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "VendorFilterVC") as? VendorFilterVC else { return }
        vc.vendorType = dashboardArray[indexPath.row - 1]?.location?[selected].location?.id
        vc.checkforLocation =  true
        self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension NewHomeVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dashboardArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return returnSlideCell(tableView, cellForRowAt: indexPath)
        } else {
            if let id = dashboardArray[indexPath.row - 1]?.type_id {
                switch id {
                case 1: // Vendors
                    return returnVendorsTableCell(tableView, cellForRowAt: indexPath)
                case 2: // popular Categories
                    return returnPopularCategoriesCell(tableView, cellForRowAt: indexPath)
                case 3: // Popular location
                    return returnPopularLocations(tableView, cellForRowAt: indexPath)
                case 7:
                    return UITableViewCell()
                case 5: // wedding tips and news
                    return returnWeddingTipsCell(tableView, cellForRowAt: indexPath)
                case 4: // testimonials
                    return returnTestimonialsCells(tableView, cellForRowAt: indexPath)
                default:
                    return UITableViewCell()
                }
            } else {
                return UITableViewCell()
            }
        }
    }
    
    fileprivate func returnTestimonialsCells(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: testimonialIdenitifier, for: indexPath) as? TestimonialDashboardCell else { return UITableViewCell() }
        cell.testionomials = dashboardArray[indexPath.row - 1]?.testimonials
        return cell
    }
    
    fileprivate func returnWeddingTipsCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: weddingIdentifier, for: indexPath) as? WeddingTippsCell else { return UITableViewCell() }
        cell.weddingTipsAndNews = dashboardArray[indexPath.row - 1]?.weddTipsNews
        cell.delegate = self
        cell.index = indexPath
        return cell
    }
    
    fileprivate func returnSlideCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let slidercell = tableView.dequeueReusableCell(withIdentifier: sildeShowIdentifier) as? HomeSliderCell else { return UITableViewCell() }
        slidercell.bannerImages = bannerData.map({ Helper.optionalStringToString(value: $0.image) })
        slidercell.collectionViewTopBanner.reloadData()
        return slidercell
    }
    
    fileprivate func returnPopularCategoriesCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: popularCategoriesIdentifier, for: indexPath) as? PopularCategoriesDashboardCell else { return UITableViewCell() }
        cell.popularCategories = dashboardArray[indexPath.row - 1]?.vendor_type
        cell.delegate = self
        cell.index = indexPath
        return cell
    }
    
    
    fileprivate func returnVendorsTableCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: vendorsIdentifiers, for: indexPath) as? VendorsCollectionCell else { return UITableViewCell() }
        cell.titleLabel.text = Helper.optionalStringToString(value: dashboardArray[indexPath.row - 1]?.title)
        cell.vendors = dashboardArray[indexPath.row - 1]?.itemlist
        cell.index = indexPath
        cell.delegate = self
        return cell
    }
    
    fileprivate func returnPopularLocations(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: popularLocationsIdentifier, for: indexPath) as? PopularLocationsDashboardCell else { return UITableViewCell() }
        cell.locations = dashboardArray[indexPath.row - 1]?.location
        cell.delegate = self
        cell.index = indexPath
        cell.reloadTable()
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 217
        } else {
            if let id = dashboardArray[indexPath.row - 1]?.type_id {
                switch id {
                case 1:
                    return 280
                case 2:
                    return 331
                case 3:
                    return 360
                case 7:
                    return 0
                case 5:
                    return 280
                case 4:
                    return 230
                default:
                    return 0
                }
            } else {
                return 0
            }
        }
    }
    
    
}
extension NewHomeVC {
    
    func homeData() {
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.Home(success: { [weak self] (homeData) in
            guard let weakself = self else { return }
            weakself.hideActivityIndicator(uiView: weakself.view)
            weakself.arrHomeDetail = homeData.homepageDetails
            weakself.arrSendLoc = homeData.locations
            if let data = homeData.homepageDetails {
                weakself.dashboardArray = data
            }
            weakself.bannerData = homeData.banner ?? []
            weakself.tblHome.reloadData()
        }){ (error) in
            self.hideActivityIndicator(uiView: self.view)
        }
        
    }
    
    
    
}
