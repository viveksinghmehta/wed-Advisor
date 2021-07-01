//
//  VendorFilterVC.swift
//  WedAdvisor
//

//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import DropDown
import SDWebImage

class VendorFilterVC: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, getFilter {
    
    func getFilter(vendor: Int, location: Int, rating: Int, clear: Bool) {
        if clear == true {
            print(rating)
            vendorDataFilter(vendor: vendor, location: location, rating: rating, clear: true)
        } else {
            if vendor == 0 && location == 0 && rating == 0 {
                
            } else {
                vendorDataFilter(vendor: vendor, location: location, rating: rating, clear: false)
            }
        }
    }
    
    
    @IBOutlet weak var viewVendor: UIView!
    @IBOutlet weak var viewRating: UIView!
    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet weak var lblVendorType: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    let dropDown = DropDown()
    let dropDowntwo = DropDown()
    let dropDownthree = DropDown()
    var arrVendor:[HomeVendorType]?
    var arrlocation : [HomeVendorType]?
    var arrVendorString = [String]()
    var arrlocationstring = [String]()
    var arrRating = ["4 & above","3 & above","2 & above","1 & above"]
    var vendorType : Int?
    var buttonIndex: Int?
    var arrVendorsData : [VendorData]?
    var arrVendorsDataComplete = [VendorData]()
    var arrVendorDataString : [String]?
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var screenSize: CGRect!
    var footerView:CustomFooterView?
    var isLoading:Bool = false
    var loadMore : Int?
    var newDict : [String:Any]?
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    let footerViewReuseIdentifier = "RefreshFooterView"
    var pageNo: Int = 1
    var arrPgingString = [String]()
    var nextPage : String?
    var checkforLocation : Bool?
    
    // New Vaules
    var vendorFilterData: VendorsFilterModel?
    var vendorsArray = [VendorInfoData]()
    
    @IBOutlet weak var CollectionFilter: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadMore = 1
        if checkforLocation == true {
            vendorDataLocation()
        } else {
            vendorData()
        }
        registerNibs()
    }
    
    
    
    
    // MARK:- Register cell
    fileprivate func registerNibs() {
        CollectionFilter.register(UINib.init(nibName: "VendorHomeCollectionCell", bundle: nil), forCellWithReuseIdentifier: "VendorHomeCollectionCell")
        CollectionFilter.dataSource = self
        CollectionFilter.delegate = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2, height: CollectionFilter.frame.size.height / 3.5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        CollectionFilter!.collectionViewLayout = layout
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnFilter(_ sender: UIButton) {
        let filter = FilterController()
        filter.vendors = vendorFilterData?.vendorTypes ?? []
        filter.amneties = vendorFilterData?.amenities ?? []
        filter.locations = vendorFilterData?.venues ?? []
        filter.vendorID = vendorType
        self.present(filter, animated: true, completion: nil)
    }
    
    // Collection View Delegate & Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vendorsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let vendorCell = CollectionFilter.dequeueReusableCell(withReuseIdentifier: "VendorHomeCollectionCell", for: indexPath) as! VendorHomeCollectionCell
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        vendorCell.lblVendorName.text = Helper.optionalStringToString(value: vendorsArray[indexPath.row].name)
        vendorCell.lblCity.text = Helper.optionalStringToString(value: vendorsArray[indexPath.row].state)
        vendorCell.imgVendor.sd_setImage(with: URL(string: GlobalConstantClass.APIConstantNames.imageBaseURL + Helper.optionalStringToString(value: vendorsArray[indexPath.row].profileImage)))
        if let isWishlist = vendorsArray[indexPath.row].isWishlist, isWishlist {
            vendorCell.btnFav.setImage(UIImage(named: "fav"), for: .normal)
        } else {
            vendorCell.btnFav.setImage(UIImage(named: "notFav"), for: .normal)
        }
        
        
        //        vendorCell.removeClosure = {
        //            if vendorCell.btnFav.currentImage == UIImage(named: "fav"){
        //                vendorCell.btnFav.setImage(UIImage(named: "notFav"), for: .normal)
        //            }
        //            else if vendorCell.btnFav.currentImage == UIImage(named: "notFav"){
        //                vendorCell.btnFav.setImage(UIImage(named: "fav"), for: .normal)
        //            }
        //            let dict = self.arrVendorsDataComplete[indexPath.row]
        //            //  self.vendorId = dict?.id
        //            self.addWish(vendorId: dict.id ?? 0)
        //        }
        
        return vendorCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "VendorProductDetailController") as? VendorProductDetailController
        vc?.vendorId = vendorsArray[indexPath.row].id
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == vendorsArray.count - 1) {
            if nextPage != "" && nextPage != nil {
                pageNo = pageNo + 1
                vendorData()
            }
        }
    }
    
    
    
    
}

extension VendorFilterVC {
    
   fileprivate func vendorData() {
    let dictparam: [String: Any] = ["id": vendorType ?? 1, "number": pageNo]
    let param: [String: Any] = ["vender_type": vendorType ?? 0, "rating": "4"]
    APIManager.sharedInstance.filterVenders(with: param) { model in
        print("")
    } failure: { error in
        print("")
    }

        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.vendorFilter(with: dictparam, success: { [weak self] (model) in
            guard let weakself = self else { return }
            weakself.hideActivityIndicator(uiView: weakself.view)
            weakself.setData(model: model)
//            // self.arrVendorsData = vendorData.vendorsInfo?.data
//
//            self.arrVendorsDataComplete.append(contentsOf: vendorData.vendorsInfo?.data ?? [])
//            print(self.arrVendorsDataComplete)
//            self.nextPage = vendorData.vendorsInfo?.next_page_url
//            self.CollectionFilter.reloadData()
//            if let data = self.arrVendorsData{
//                for i in data{
//                    self.arrPgingString.append(i.name ?? "")
//                }
//            }
//
//            print(self.arrVendorsData?.count)
//            if let name = vendorData.vendor_types{
//                for i in name{
//                    self.arrVendorString.append(i.name ?? "")
//                }
//            }
//
//            if let loc = vendorData.venues{
//                for i in loc{
//                    self.arrlocationstring.append(i.city ?? "")
//                }
//            }
//            if let vendorInfo = vendorData.vendorsInfo?.data{
//                for i in vendorInfo{
//                    self.arrVendorDataString?.append(i.name ?? "")
//                }
//            }
        }) { [weak self] (error) in
            guard let weakself = self else { return }
            weakself.hideActivityIndicator(uiView: weakself.view)
        }
    }
    
    
    fileprivate func setData(model: VendorsFilterModel) {
        vendorFilterData = model
        print(model)
        vendorsArray.append(contentsOf: model.vendorsInfo?.data ?? [])
        CollectionFilter.reloadData()
    }
    
    
    func vendorDataLocation() {
        let dictparam: [String: Any] = ["id":vendorType ?? 1, "number": pageNo]
        
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.vendorFilterLocation(with: dictparam, success: { (vendorData) in
            self.hideActivityIndicator(uiView: self.view)
            print(self.arrVendorsData?.count)
            self.arrVendor = vendorData.vendor_types
            self.arrlocation = vendorData.venues
            // self.arrVendorsData = vendorData.vendorsInfo?.data
            
            self.arrVendorsDataComplete.append(contentsOf: vendorData.vendorsInfo?.data ?? [])
            print(self.arrVendorsDataComplete)
            self.nextPage = vendorData.vendorsInfo?.next_page_url
            self.CollectionFilter.reloadData()
            if let data = self.arrVendorsData{
                for i in data{
                    self.arrPgingString.append(i.name ?? "")
                }
            }
            
            if let name = vendorData.vendor_types{
                for i in name{
                    self.arrVendorString.append(i.name ?? "")
                }
            }
            
            if let loc = vendorData.venues{
                for i in loc{
                    self.arrlocationstring.append(i.city ?? "")
                }
            }
            if let vendorInfo = vendorData.vendorsInfo?.data{
                for i in vendorInfo{
                    self.arrVendorDataString?.append(i.name ?? "")
                }
            }
            print(self.arrVendorString)
            print(self.arrlocationstring)
            self.dropDown.dataSource = self.arrVendorString
            self.dropDowntwo.dataSource = self.arrlocationstring
            self.dropDownthree.dataSource = self.arrRating
            //self.vendorsCollView.reloadData()
        }){ (error) in
            self.hideActivityIndicator(uiView: self.view)
            
            // SupportMethod.showAlertMessage(messageStr: "Try Again")
        }
    }
    
    func vendorDataFilter(vendor:Int, location:Int, rating:Int, clear: Bool) {
        arrVendor = []
        arrlocation = []
        arrVendorString = [String]()
        arrlocationstring = [String]()
        arrVendorsData = []
        arrVendorDataString = [String]()
        arrVendorsDataComplete = []
        print(rating)
        
        if rating == 0{
            let dictparam = ["id":vendorType ?? 1,
                             "vendor_type": vendor,
                             "location":location,
                             "clear":clear
                ] as [String:Any]
            newDict = dictparam
        } else if location == 0 {
            let dictparam = ["id":vendorType ?? 1,
                             "vendor_type": vendor,
                            "ratings":rating,
                             "clear":clear
                ] as [String:Any]
            newDict = dictparam
        } else{
            let dictparam = ["id":vendorType ?? 1,
                             "vendor_type": vendor,
                             "location":location,
                             "ratings":rating,
                             "clear":clear
                ] as [String:Any]
            newDict = dictparam
        }
        
        

        
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.vendorFilterData(with: newDict ?? [:], success: { (vendorData) in
            self.hideActivityIndicator(uiView: self.view)
           self.arrVendor = vendorData.vendor_types
            self.arrlocation = vendorData.venues
            // self.arrVendorsData = vendorData.vendorsInfo?.data
            
            self.arrVendorsDataComplete.append(contentsOf: vendorData.vendorsInfo?.data ?? [])
            print(self.arrVendorsDataComplete)
            self.nextPage = vendorData.vendorsInfo?.next_page_url
            self.CollectionFilter.reloadData()
            if let data = self.arrVendorsData{
                for i in data{
                    self.arrPgingString.append(i.name ?? "")
                }
            }
            
            print(self.arrVendorsData?.count)
            if let name = vendorData.vendor_types{
                for i in name{
                    self.arrVendorString.append(i.name ?? "")
                }
            }
            
            if let loc = vendorData.venues{
                for i in loc{
                    self.arrlocationstring.append(i.city ?? "")
                }
            }
            if let vendorInfo = vendorData.vendorsInfo?.data{
                for i in vendorInfo{
                    self.arrVendorDataString?.append(i.name ?? "")
                }
            }
            print(self.arrVendorString)
            print(self.arrlocationstring)
            self.dropDown.dataSource = self.arrVendorString
            self.dropDowntwo.dataSource = self.arrlocationstring
            self.dropDownthree.dataSource = self.arrRating
            //self.vendorsCollView.reloadData()
        }){ (error) in
            self.hideActivityIndicator(uiView: self.view)
            
            // SupportMethod.showAlertMessage(messageStr: "Try Again")
        }
    }
}
extension VendorFilterVC{
    func addWish(vendorId:Int)
    {
        let dictparam = ["product_id": vendorId
            ] as [String:Any]
        
        //    self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.addWishList(with: dictparam, success: { (dataRemove) in
            //self.hideActivityIndicator(uiView: self.view)
            print(dataRemove.status)
            if dataRemove.status == 200{
                //  self.alertShow(msg: "Login Failed")
                
            }
            else if dataRemove.status == 201{
                //self.alertShow(msg: "Login Failed")
                
            }
        }){ (error) in
            // self.hideActivityIndicator(uiView: self.view)
        }
    }
    
}
