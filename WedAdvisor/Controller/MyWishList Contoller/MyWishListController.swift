//
//  MyWishListController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 21/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
protocol wishList {
    func wishList(value : Bool)
}
class MyWishListController: UIViewController {
    
    @IBOutlet weak var wishListCollection: UICollectionView!
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var arrWish : [MywishListModelData]?
    var vendorId : Int?
    var delegate : wishList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        statusbarcolor()
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width-20
        screenHeight = screenSize.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth / 2, height: 510 / 2.2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        wishListCollection!.collectionViewLayout = layout
        wishListData()
    }
    
    // MARK:- Register cell
    func registerNibs() {
        wishListCollection.register(UINib.init(nibName: "MyWishListCell", bundle: nil), forCellWithReuseIdentifier: "MyWishListCell")
     }
    
    // Status bar color
    func statusbarcolor() {
        let statusBar =  UIView()
        statusBar.frame = UIApplication.shared.statusBarFrame
        statusBar.backgroundColor = WedAdviserColor.themeOrangeColor()
        UIApplication.shared.keyWindow?.addSubview(statusBar)
    }
    
    @IBAction func btnBack(sender: UIButton) {
        delegate?.wishList(value: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension MyWishListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrWish?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = wishListCollection.dequeueReusableCell(withReuseIdentifier: "MyWishListCell", for: indexPath as IndexPath) as! MyWishListCell
        if arrWish?.count != 0 {
            cell.lblName.text = arrWish?[indexPath.row].vendor?.name
            cell.lblCity.text = arrWish?[indexPath.row].location?.first?.city
            // cell.lblPrice.text = "₹\(dict?.vendor. ?? 0) \(dict.base_price_unit ?? "")"
            cell.imgImage.sd_setImage(with: URL(string: GlobalConstantClass.APIConstantNames.imageBaseURL + Helper.optionalStringToString(value: arrWish?[indexPath.row].vendor?.profile_image)), placeholderImage: UIImage(systemName: "photo.on.rectangle.angled"))
            cell.imgImage.tintColor = UIColor(named: "AppLightOrangeColor")
        }
        
        cell.removeClosure = {
            let dict = self.arrWish?[indexPath.row]
            self.remove(vendorId: dict?.vendor_id ?? 0)
          //  vendorId = dict?.vendor_id
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "VendorProductDetailController") as? VendorProductDetailController
        vc?.vendorId = arrWish?[indexPath.row].vendor_id
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}


extension MyWishListController {
    func wishListData() {
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.MyWishlist(success: { [weak self] (dashBoardData) in
            guard let weakself = self else { return }
            weakself.hideActivityIndicator(uiView: weakself.view)
            weakself.arrWish = dashBoardData.vendorsDetails?.data
            weakself.wishListCollection.reloadData()
        }) { [weak self] (error) in
            guard let weakself = self else { return }
            weakself.hideActivityIndicator(uiView: weakself.view)
            
            
        }
    }
    
    func remove(vendorId: Int) {
        let dictparam = ["vendor_id": vendorId] as [String : Any]
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.removeWishList(with: dictparam, success: { [weak self] (dataRemove) in
            guard let weakself = self else { return }
            weakself.hideActivityIndicator(uiView: weakself.view)
            if dataRemove.status == 200 {
                weakself.wishListData()
            }
        }){ [weak self] (error) in
            guard let weakself = self else { return }
            weakself.hideActivityIndicator(uiView: weakself.view)
        }
    }
}
