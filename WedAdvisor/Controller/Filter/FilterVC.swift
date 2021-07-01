//
//  FilterVC.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 13/03/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
protocol getFilter {
    func getFilter(vendor:Int, location:Int, rating:Int, clear: Bool)
}

class FilterVC: UIViewController {
    @IBOutlet weak var tblCategory: UITableView!
    @IBOutlet weak var tblFilter: UITableView!
    var arrOption = ["Vendor Type","Location","Ratings"]
    var arrRating = ["4 & above","3 & above","2 & above","1 & above"]
    var arrRatingIds = [4,3,2,1]
   // var arrList = ["All", "Cotton", "Silk", "Net", "Blanded"]
    var vendorType : Int?
    var arrVendorString = [String]()
     var arrlocationstring = [String]()
    var arrVendor:[HomeVendorType]?
    var arrlocation : [HomeVendorType]?
    var arrVendorsData : [VendorData]?
    var arrVendorIds = [Int]()
    var arrlocationIds = [Int]()
    var arrVendorDataString : [String]?
    var type : String?
    var selectedValue : Bool?
    var vendor_type : Int?
    var location : Int?
    var ratings : Int?
    var delegateFilter: getFilter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblCategory.delegate = self
        tblCategory.dataSource = self
        tblFilter.delegate = self
        tblFilter.dataSource = self
        self.registerNibs()
        type = "Vendor Type"
//       vendorData()
    }
     // MARK:- Register cell
    func registerNibs(){
        let categoryItem = UINib(nibName: "FilterCategoryCell" , bundle: nil)
        self.tblCategory.register(categoryItem, forCellReuseIdentifier: "FilterCategoryCell")
        let categoryList = UINib(nibName: "FilterListingCell" , bundle: nil)
        self.tblFilter.register(categoryList, forCellReuseIdentifier: "FilterListingCell")
        
    }
    //MARK:- Button outlets
      @IBAction func btnClose(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
      }
    
    @IBAction func btnApplyFilter(_ sender: Any) {
        delegateFilter?.getFilter(vendor: vendor_type ?? 1, location: location ?? 0, rating: ratings ?? 0, clear: false)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnClearAll(_ sender: Any) {
           delegateFilter?.getFilter(vendor: vendor_type ?? 0, location: location ?? 0, rating: ratings ?? 0, clear: true)
           self.dismiss(animated: true, completion: nil)
       }
       

}
extension FilterVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblCategory{
            return arrOption.count
        }
        else{
            if type == "Vendor Type"{
                return arrVendorString.count
            }
            else if type == "Location"{
                return arrlocationstring.count
            }
            else if type == "Ratings"{
                return arrRating.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblCategory{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCategoryCell") as! FilterCategoryCell
                   let dict = arrOption[indexPath.row]
                   cell.lblTerm.text = dict
                   return cell
        }
        else if tableView == tblFilter{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterListingCell") as! FilterListingCell
//            let typeVendor = arrVendorIds[indexPath.row]
//                       let locationdata = arrlocationIds[indexPath.row]
//                       let ratingData = arrRatingIds[indexPath.row]
    if type == "Vendor Type"{
               let dict = arrVendorString[indexPath.row]
               cell.lblType.text = dict
           cell.imgbox.image = #imageLiteral(resourceName: "ic_uncheck")
               cell.selectClosure = {

               }
               return cell
            }
            else if type == "Location"{
                let dict = arrlocationstring[indexPath.row]
                cell.lblType.text = dict
                cell.selectClosure = {
                }
                return cell
            }
            else if type == "Ratings"{
                let dict = arrRating[indexPath.row]
                cell.lblType.text = dict
                cell.selectClosure = {
                    
                }
                return cell
            }
            
        }
       return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if tableView == tblCategory{
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.contentView.backgroundColor = UIColor.white
            }
            let dict = arrOption[indexPath.row]
            if dict == "Vendor Type"{
                type = "Vendor Type"
                 selectedValue = true
                tblFilter.reloadData()
            }
            else if dict == "Location"{
                  type = "Location"
                selectedValue = true
                tblFilter.reloadData()
            }
            else if dict == "Ratings"{
              type = "Ratings"
                selectedValue = true
                tblFilter.reloadData()
            }
        }
        else if tableView == tblFilter{
            let cell = tableView.cellForRow(at: indexPath) as! FilterListingCell
            if arrOption.count != 0{
                let dict = arrlocationstring[indexPath.row]
                let typeVendor = arrVendorIds[indexPath.row]
                let locationdata = arrlocationIds[indexPath.row]
                let ratingData = arrRatingIds[indexPath.row]
                if type == "Vendor Type"{
                    vendor_type = typeVendor
                    cell.imgbox.image = #imageLiteral(resourceName: "t_ic-checked")

                }
                else if type == "Location"{
                    cell.imgbox.image = #imageLiteral(resourceName: "t_ic-checked")
                   location = locationdata
                    
                }
                else if type == "Ratings"{
                    ratings = ratingData
                    cell.imgbox.image = #imageLiteral(resourceName: "t_ic-checked")

                }
            }


        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == tblCategory{
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.contentView.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
            }
            
        }
        else if tableView == tblFilter{
            let cell = tableView.cellForRow(at: indexPath) as! FilterListingCell
           cell.imgbox.image = #imageLiteral(resourceName: "ic_check")
        }
        
    }
}
extension FilterVC{
//    func vendorData()
//    {
//        let dictparam = ["id":vendorType ?? 1] as [String:Any]
//
//        self.showActivityIndicator(uiView: self.view)
//        APIManager.sharedInstance.vendorFilter(with: dictparam, success: { (vendorData) in
//            self.hideActivityIndicator(uiView: self.view)
//            print(vendorData)
//            self.arrVendor = vendorData.vendor_types
//            self.arrlocation = vendorData.venues
//            self.arrVendorsData = vendorData.vendorsInfo?.data
//
//            if let name = vendorData.vendor_types{
//                for i in name{
//                    self.arrVendorString.append(i.name ?? "")
//                }
//            }
//
//            if let loc = vendorData.venues{
//                for i in loc{
//                    self.arrlocationstring.append(i.city ?? "")
//                    self.arrlocationIds.append(i.id ?? 0)
//
//                }
//            }
//            if let vendorInfo = vendorData.vendor_types{
//                for i in vendorInfo{
//                    self.arrVendorDataString?.append(i.name ?? "")
//                    self.arrVendorIds.append(i.id ?? 0)
//
//                }
//            }
//            print(self.arrVendorString)
//            print(self.arrlocationstring)
//            self.tblFilter.reloadData()
//            //self.vendorsCollView.reloadData()
//        }){ (error) in
//            self.hideActivityIndicator(uiView: self.view)
//
//            // SupportMethod.showAlertMessage(messageStr: "Try Again")
//        }
//    }
    
}
