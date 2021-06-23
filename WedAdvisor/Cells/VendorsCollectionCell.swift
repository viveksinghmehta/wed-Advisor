//
//  VendorsCollectionCell.swift
//  WedAdvisor
//
//  Created by WishACloud on 21/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import SDWebImage

class VendorsCollectionCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ventorCollectionView: UICollectionView!
    
    
    private let identifier: String = "VendorHomeCollectionCell"
    var vendors: [HomeItemList]?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionInit()
    }
    
    fileprivate func collectionInit() {
        ventorCollectionView.register(UINib(nibName: "VendorHomeCollectionCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        ventorCollectionView.delegate = self
        ventorCollectionView.dataSource = self
        ventorCollectionView.reloadData()
    }
    
    func reloadVendors() {
        ventorCollectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension VendorsCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let vendors = vendors {
           return vendors.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? VendorHomeCollectionCell else { return UICollectionViewCell() }
        cell.lblVendorName.text = Helper.optionalStringToString(value: vendors?[indexPath.row].name)
        cell.lblCity.text = Helper.optionalStringToString(value: vendors?[indexPath.row].city_name).capitalizingFirstLetter()
        cell.lblDay.text = "₹ " + Helper.optionalIntToString(value: vendors?[indexPath.row].base_price) + " " + Helper.optionalStringToString(value: vendors?[indexPath.row].base_price_unit)
        if let isWishlist = vendors?[indexPath.row].is_wishlist, isWishlist {
            cell.btnFav.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.btnFav.tintColor = .red
        } else {
            cell.btnFav.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.btnFav.tintColor = .lightGray
        }
        cell.lblRating.text = "\(Helper.optionalStringDouble(value: vendors?[indexPath.row].avg_rating))"
        cell.imgVendor.sd_setImage(with: URL(string: GlobalConstantClass.APIConstantNames.imageBaseURL + Helper.optionalStringToString(value: vendors?[indexPath.row].profile_image)), placeholderImage: UIImage(systemName: "photo.on.rectangle.angled"))
        cell.imgVendor.tintColor = WedAdviserColor.themeOrangeColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.45 , height: collectionView.bounds.height - 10)
    }
    
}
