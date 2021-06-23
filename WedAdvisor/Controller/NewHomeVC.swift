//
//  NewHomeVC.swift
//  WedAdvisor
//

//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

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
    
    //MARK:- NewVariables
    var dashboardArray = [HomeDetail?]()
    var bannerData = [HomeBanner]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibs()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // if checkfromwish == true{
           arrTitle = []
            homeData()
            //tblHome.rowHeight = UITableView.automaticDimension
        //}
    }
    
    // MARK:- Register cell
    fileprivate func registerNibs() {
        tblHome.register(UINib(nibName: "HomeSliderCell" , bundle: nil), forCellReuseIdentifier: sildeShowIdentifier)
        tblHome.register(UINib(nibName: "VendorsCollectionCell" , bundle: nil), forCellReuseIdentifier: vendorsIdentifiers)
        tblHome.register(UINib(nibName: "PopularLocationsDashboardCell", bundle: nil), forCellReuseIdentifier: popularLocationsIdentifier)
        tblHome.register(UINib(nibName: "PopularCategoriesDashboardCell", bundle: nil), forCellReuseIdentifier: popularCategoriesIdentifier)
        tblHome.dataSource = self
        tblHome.delegate = self
    }
    
    @IBAction func btnMenu(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
        vc.delegateMenu = self
        let transition = CATransition()
        transition.duration = 0.1
        // transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func btnProfile(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SelectOptionsController") as? SelectOptionsController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func locationBtnTapped(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "LocationController") as? LocationController else { return }
        vc.arrPopularLoc = arrSendLoc
        vc.arrPopularLocNew = arrSendLoc
        present(vc, animated: true, completion: nil)
//        self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func changeLocation(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "LocationController") as? LocationController else { return }
        vc.arrPopularLoc = arrSendLoc
        vc.arrPopularLocNew = arrSendLoc
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SearchingVC") as? SearchingVC else { return }
        present(vc, animated: true, completion: nil)
    }
    
}

extension NewHomeVC: PopularLocationDelegate {
    
    func popularLocationSelected(index: Int) {
        print(index)
    }
    
}

extension NewHomeVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dashboardArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let slidercell = tableView.dequeueReusableCell(withIdentifier: sildeShowIdentifier) as? HomeSliderCell else {return UITableViewCell() }
            slidercell.bannerImages = bannerData.map({ Helper.optionalStringToString(value: $0.image) })
            return slidercell
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
                case 5:
                    return UITableViewCell()
                case 4:
                    return UITableViewCell()
                default:
                    return UITableViewCell()
                }
            } else {
                return UITableViewCell()
            }
        }
    }
    
    fileprivate func returnPopularCategoriesCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: popularCategoriesIdentifier, for: indexPath) as? PopularCategoriesDashboardCell else { return UITableViewCell() }
        cell.popularCategories = dashboardArray[indexPath.row - 1]?.vendor_type
        return cell
    }
    
    
    fileprivate func returnVendorsTableCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: vendorsIdentifiers, for: indexPath) as? VendorsCollectionCell else { return UITableViewCell() }
        cell.titleLabel.text = Helper.optionalStringToString(value: dashboardArray[indexPath.row - 1]?.title)
        cell.vendors = dashboardArray[indexPath.row - 1]?.itemlist
        return cell
    }
    
    fileprivate func returnPopularLocations(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: popularLocationsIdentifier, for: indexPath) as? PopularLocationsDashboardCell else { return UITableViewCell() }
        cell.locations = dashboardArray[indexPath.row - 1]?.location
        cell.delegate = self
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
                    return UITableView.automaticDimension
                case 7:
                    return 0
                case 5:
                    return 0
                case 4:
                    return 0
                default:
                    return 0
                }
            } else {
                return 0
            }
        }
    }
    
    
}
extension NewHomeVC{
    func homeData()
    {
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
            
            // SupportMethod.showAlertMessage(messageStr: "Try Again")
        }
        
    }
    
    
    
}
