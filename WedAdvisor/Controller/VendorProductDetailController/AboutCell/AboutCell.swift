//
//  AboutCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 10/02/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class AboutCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblHotel: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblAmenities: UILabel!
    @IBOutlet weak var collectionAmenities: UICollectionView!
    @IBOutlet weak var heightCollectionView: NSLayoutConstraint!
    @IBOutlet weak var heightCollection: NSLayoutConstraint!
    @IBOutlet weak var heightCollectionBackView: NSLayoutConstraint!
    @IBOutlet weak var collectionSimmilarVendor: UICollectionView!
    @IBOutlet weak var viewAminities: UIView!
    @IBOutlet weak var btnDrop: UIButton!
    
 //   static let aboutSharedInstance = AboutCell()
    var itemlist: [HomeItemList]?
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var screenSize: CGRect!
    var arrAmnities = [amenitiesData]()
    var vendorId : Int?
    var showDrop = true
    var selectDrop : (() -> ())?


    override func awakeFromNib() {
        super.awakeFromNib()
        registerNibs()
        collectionAmenities.delegate = self
        collectionAmenities.dataSource = self
        collectionSimmilarVendor.delegate = self
        collectionSimmilarVendor.dataSource = self
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width-50
        screenHeight = screenSize.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: screenWidth/2, height: screenHeight/20)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionAmenities!.collectionViewLayout = layout
        let layout1: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout1.scrollDirection = .horizontal
        layout1.itemSize = CGSize(width: screenWidth/2, height: 240)
        layout1.minimumInteritemSpacing = 0
        layout1.minimumLineSpacing = 0
        collectionSimmilarVendor!.collectionViewLayout = layout1
        print(vendorId)
        viewAminities.isHidden = false
    }
    // Register Nib
    func registerNibs(){
        collectionAmenities.register(UINib.init(nibName: "AmenitiesCell", bundle: nil), forCellWithReuseIdentifier: "AmenitiesCell")
        collectionSimmilarVendor.register(UINib.init(nibName: "VendorHomeCollectionCell", bundle: nil), forCellWithReuseIdentifier: "VendorHomeCollectionCell")

    }
    
    // MARK:- Tableview Height
    func connfigCollectionHeight(){
       // if arrAmnities.count == 0{
//            let numberOfLines = arrAmnities.count
//            heightCollection.constant = CGFloat(17*numberOfLines)
//            heightCollectionView.constant = CGFloat(17*numberOfLines)
//            heightCollectionBackView.constant = CGFloat(17*numberOfLines)
//            collectionAmenities.reloadData()
//        }
      //  else{
            let numberOfLines = arrAmnities.count 
            heightCollection.constant = CGFloat(17*numberOfLines)
            heightCollectionView.constant = CGFloat(17*numberOfLines)
            heightCollectionBackView.constant = CGFloat(17*numberOfLines)
            collectionAmenities.reloadData()
       // }
    }

    //MARK:- Button Outlet
    @IBAction func btnDropDown(_ sender: Any) {
//     selectDrop!()
    }
    
    //MARK:- Collectionview datasource & Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionAmenities{
            return arrAmnities.count

        }
        else{
            return itemlist?.count ?? 0

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionAmenities{
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AmenitiesCell", for: indexPath) as! AmenitiesCell
            let dict = arrAmnities[indexPath.row]
            cell.lblAminity.text = dict.amenities_option
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VendorHomeCollectionCell", for: indexPath as IndexPath) as! VendorHomeCollectionCell
            if let dict = itemlist?[indexPath.row]{
                cell.lblVendorName.text = dict.name
                cell.lblCity.text = "\(dict.state ?? "")"
                cell.lblDay.text = "₹\(dict.base_price ?? 0) \(dict.base_price_unit ?? "")"
                cell.imgVendor.sd_setImage(with: URL(string: "https://wed-advisor.com/images/vendor-img-1.jpg"), placeholderImage: UIImage(named: "placeholder.png"))
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
