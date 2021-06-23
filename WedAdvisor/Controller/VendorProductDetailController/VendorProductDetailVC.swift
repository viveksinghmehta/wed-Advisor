//
//  VendorProductDetailVC.swift
//  WedAdvisor
//

//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class VendorProductDetailVC: UIViewController {
     var vendorId : Int?
    var itemlist: [HomeItemList]?
    var hotelName : String?
    var countryName : String?
    var rating: String?
    var Review : String?
    var desc : String?
    var arrAmnities : [amenitiesData]?

    @IBOutlet weak var tblDetail: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblDetail.dataSource = self
        tblDetail.delegate = self
        self.registerNibs()
         vendorData()
    }
    
//MARK:- Cell
  func registerNibs(){
      let aboutNib = UINib(nibName: "VendorDetailTopTableCell" , bundle: nil)
      self.tblDetail.register(aboutNib, forCellReuseIdentifier: "VendorDetailTopTableCell")
     let aboutNibTwo = UINib(nibName: "VendorOptionCell" , bundle: nil)
        self.tblDetail.register(aboutNibTwo, forCellReuseIdentifier: "VendorOptionCell")
    let aboutNibThree = UINib(nibName: "VendorOptionSelectionCell" , bundle: nil)
           self.tblDetail.register(aboutNibThree, forCellReuseIdentifier: "VendorOptionSelectionCell")
      
  }


}
extension VendorProductDetailVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
            return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tblDetail.dequeueReusableCell(withIdentifier: "VendorDetailTopTableCell", for: indexPath) as! VendorDetailTopTableCell
            cell.hotelNameLbl.text = hotelName
            cell.countryNameLbl.text = countryName
            cell.starCountLbl.text = rating
            cell.reviewCountLbl.text = Review
            cell.backClosure = {
                self.navigationController?.popViewController(animated: true)
            }
            return cell
        }
        else if indexPath.section == 1{
            let cell = tblDetail.dequeueReusableCell(withIdentifier: "VendorOptionCell", for: indexPath) as! VendorOptionCell
            return cell
        }
        else if indexPath.section == 2{
            let cell = tblDetail.dequeueReusableCell(withIdentifier: "VendorOptionSelectionCell", for: indexPath) as! VendorOptionSelectionCell
            cell.desc = desc
        
//            cell.hotelName = hotelName
//            cell.itemlist = itemlist
//            cell.arrAmnities = arrAmnities
//            cell.connfigCollectionHeightwo()
//            cell.connfigCollectionHeight()
            cell.tblAbout.reloadData()
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 500
        }
        else{
            return 65
        }
    }
}
extension VendorProductDetailVC{
    func vendorData() {
        let dictparam = ["id":vendorId ?? 0] as [String:Any]
        
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.vendorDetail(with: dictparam, success: { (vendorData) in
            self.hideActivityIndicator(uiView: self.view)
            print(vendorData)
            self.hotelName = vendorData.vendor?.name
            self.countryName = vendorData.vendor?.getcity?.city
            self.rating = "\(vendorData.vendor?.avg_rating ?? 0)"
            self.Review = "\(vendorData.vendor?.count_user_review ?? 0) Reviews"
            self.desc = vendorData.vendor?.notes
            self.itemlist = vendorData.similarVendors
            self.arrAmnities = vendorData.amenities
//            self.aboutTbl.reloadData()
            //    self.collectionSimmilarVendor.reloadData()
            self.tblDetail.reloadData()
        }){ (error) in
            self.hideActivityIndicator(uiView: self.view)
            
            // SupportMethod.showAlertMessage(messageStr: "Try Again")
        }
    }
}
