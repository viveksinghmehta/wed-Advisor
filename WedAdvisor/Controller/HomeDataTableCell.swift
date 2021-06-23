//
//  HomeDataTableCell.swift
//  WedAdvisor
//
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import SDWebImage


protocol nextVC {
    func getCell(index: Int, id: Int)
}


class HomeDataTableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionData: UICollectionView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var heightHeader: NSLayoutConstraint!
    
    var sectioncount: Int?
    var arrHomeDetail : [HomeDetail]?
    var arrItemList : [HomeItemList]?
    var arrPopularCat : [HomeVendorType]?
    var arrLatestWed : [HomeItemList]?
    var arrPopularLoc : [GetLocation]?
    var arrHowItWork : [GetHowWork]?
    var arrTestimonial : [GetTestimonial]?
    var arrGetWedding : [GetweddTipsNews]?
    var checkForSix : String?
    var checkforseven : String?
    var checkForOne : String?
    var checkForTwo : String?
    var arrimg = ["h1","h2","h3"]
    var delegate : nextVC?
    var checkForAllVendor : Bool?
    var vendorId: Int?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
        registerNibs()
        collectionData.dataSource = self
        collectionData.delegate = self
        
    }
    
    
    // Register Nib
    func registerNibs(){
        collectionData.register(UINib.init(nibName: "VendorHomeCollectionCell", bundle: nil), forCellWithReuseIdentifier: "VendorHomeCollectionCell")
        collectionData.register(UINib.init(nibName: "CategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionCell")
        collectionData.register(UINib.init(nibName: "TestimonialCell", bundle: nil), forCellWithReuseIdentifier: "TestimonialCell")
        collectionData.register(UINib.init(nibName: "SetCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SetCollectionCell")
        collectionData.register(UINib.init(nibName: "UpcomingCollectionCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingCollectionCell")
        collectionData.register(UINib.init(nibName: "WeddingAffairsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "WeddingAffairsCollectionCell")
    }
    
    
    //MARK:- Collectionview datasource & Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if sectioncount == 1 {
            if checkForOne == "featured vendors"{
                return arrItemList?.count ?? 0
            } else {
                return arrPopularCat?.count ?? 0
            }
        } else if sectioncount == 2 {
            if checkForTwo == "featured vendors" {
                return arrItemList?.count ?? 0
            } else {
                return arrPopularCat?.count ?? 0
            }
        } else if sectioncount == 3 {
            return arrLatestWed?.count ?? 0
        } else if sectioncount == 4 {
            return arrPopularLoc?.count ?? 0
            
        } else if sectioncount == 5 {
            return arrHowItWork?.count ?? 0
        } else if sectioncount == 6 {
            if checkForSix == "wedding tips and news"{
                return arrGetWedding?.count ?? 0
                
            } else {
                return arrTestimonial?.count ?? 0
            }
        } else if sectioncount == 7 {
            if checkforseven == "wedding tips and news"{
                return arrGetWedding?.count ?? 0
            } else {
                return arrTestimonial?.count ?? 0
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if sectioncount == 1 {
            if checkForOne == "featured vendors" {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VendorHomeCollectionCell", for: indexPath as IndexPath) as! VendorHomeCollectionCell
                print(arrItemList)
                if let dict = arrItemList?[indexPath.row] {
                    cell.lblVendorName.text = dict.name
                    cell.lblCity.text = "\(dict.state ?? "")"
                    cell.lblDay.text = "₹\(dict.base_price ?? 0) \(dict.base_price_unit ?? "")"
                    if dict.is_wishlist == true {
                        cell.btnFav.setImage(UIImage(named: "fav"), for: .normal)
                    } else {
                        cell.btnFav.setImage(UIImage(named: "notFav"), for: .normal)
                    }
                    if let url = URL(string: "https://wed-advisor.com/images/\(dict.profile_image ?? "vendor-img-1.jpg")") {
                        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                            guard let data = data, error == nil else { return }
                            DispatchQueue.main.async { /// execute on main thread
                                cell.imgVendor.image = UIImage(data: data)
                            }
                        }
                        task.resume()
                    }
                    // cell.imgVendor.sd_setImage(with: URL(string: "https://wed-advisor.com/images/vendor-img-1.jpg"), placeholderImage: UIImage(named: "placeholder.png"))
                }
//                cell.removeClosure = {
//                    if cell.btnFav.imageView?.image == UIImage(named: "fav"){
//                        cell.btnFav.setImage(UIImage(named: "notFav"), for: .normal)
//                    }
//                    else{
//                        cell.btnFav.setImage(UIImage(named: "fav"), for: .normal)
//                        
//                    }
//                    let dict = self.arrItemList?[indexPath.row]
//                    self.vendorId = dict?.id
//                    
//                    self.addWish(vendorId: dict?.id ?? 0)
//                    
//                }
                
                return cell
            }
            else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath as IndexPath) as! CategoryCollectionCell
                if indexPath.row != 5{
                    let layout = UICollectionViewFlowLayout()
                    layout.scrollDirection = .vertical
                    // checkForAllVendor = false
                    let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
                    let dict = arrPopularCat?[indexPath.row]
                    cell.lblName.text = dict?.name
                    if let url = URL(string: "https://wed-advisor.com/images/popular_category/\(dict?.logo ?? "")") {
                        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                            guard let data = data, error == nil else { return }
                            
                            DispatchQueue.main.async { /// execute on main thread
                                cell.viewImage.image = UIImage(data: data)
                            }
                        }
                        task.resume()
                    }
                }
                else if indexPath.row == 5{
                    let layout = UICollectionViewFlowLayout()
                    layout.scrollDirection = .vertical
                    checkForAllVendor = true
                    let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
                    cell.lblName.text = "ADD MORE"
                    cell.viewImage.image = UIImage(named: "Logout-logo")
                }
                return cell
            }
        }
        else if sectioncount == 2{
            if checkForTwo == "featured vendors"{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VendorHomeCollectionCell", for: indexPath as IndexPath) as! VendorHomeCollectionCell
                print(arrItemList)
                if let dict = arrItemList?[indexPath.row]{
                    cell.lblVendorName.text = dict.name
                    cell.lblCity.text = "\(dict.state ?? "")"
                    cell.lblDay.text = "₹\(dict.base_price ?? 0) \(dict.base_price_unit ?? "")"
                    if dict.is_wishlist == true{
                        cell.btnFav.setImage(UIImage(named: "fav"), for: .normal)
                    }
                    else{
                        cell.btnFav.setImage(UIImage(named: "notFav"), for: .normal)
                        
                    }
                    
                    
                    if let url = URL(string: "https://wed-advisor.com/images/\(dict.profile_image ?? "vendor-img-1.jpg")") {
                        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                            guard let data = data, error == nil else { return }
                            
                            DispatchQueue.main.async { /// execute on main thread
                                cell.imgVendor.image = UIImage(data: data)
                            }
                        }
                        
                        task.resume()
                    }
                    // cell.imgVendor.sd_setImage(with: URL(string: "https://wed-advisor.com/images/vendor-img-1.jpg"), placeholderImage: UIImage(named: "placeholder.png"))
                }
                
//                cell.removeClosure = {
//                    if cell.btnFav.imageView?.image == UIImage(named: "fav"){
//                        cell.btnFav.setImage(UIImage(named: "notFav"), for: .normal)
//                    }
//                    else{
//                        cell.btnFav.setImage(UIImage(named: "fav"), for: .normal)
//
//                    }
//                    let dict = self.arrItemList?[indexPath.row]
//                    self.vendorId = dict?.id
//
//                    self.addWish(vendorId: dict?.id ?? 0)
//                }
                return cell
            }
            else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath as IndexPath) as! CategoryCollectionCell
                if indexPath.row != 5{
                    let layout = UICollectionViewFlowLayout()
                    layout.scrollDirection = .vertical
                    // checkForAllVendor = false
                    let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
                    let dict = arrPopularCat?[indexPath.row]
                    cell.lblName.text = dict?.name
                    if let url = URL(string: "https://wed-advisor.com/images/popular_category/\(dict?.logo ?? "")") {
                        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                            guard let data = data, error == nil else { return }
                            DispatchQueue.main.async { /// execute on main thread
                                cell.viewImage.image = UIImage(data: data)
                            }
                        }
                        task.resume()
                    }
                }
                else if indexPath.row == 5{
                    let layout = UICollectionViewFlowLayout()
                    layout.scrollDirection = .vertical
                    checkForAllVendor = true
                    let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
                    cell.lblName.text = "ADD MORE"
                    cell.viewImage.image = UIImage(named: "Logout-logo")
                }
                return cell
            }
        }
        else if sectioncount == 3{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VendorHomeCollectionCell", for: indexPath as IndexPath) as! VendorHomeCollectionCell
            if let dict = arrLatestWed?[indexPath.row]{
                cell.lblVendorName.text = dict.name
                cell.lblCity.text = dict.state ?? ""
                cell.lblDay.text = "₹\(dict.base_price ?? 0) \(dict.base_price_unit ?? "")"
                if dict.is_wishlist == true{
                    cell.btnFav.setImage(UIImage(named: "fav"), for: .normal)
                }
                else{
                    cell.btnFav.setImage(UIImage(named: "notFav"), for: .normal)
                    
                }
                if let url = URL(string: "https://wed-advisor.com/images/\(dict.profile_image ?? "vendor-img-1.jpg")") {
                    let task = URLSession.shared.dataTask(with: url) { data, response, error in
                        guard let data = data, error == nil else { return }
                        
                        DispatchQueue.main.async { /// execute on main thread
                            cell.imgVendor.image = UIImage(data: data)
                        }
                    }
                    
                    task.resume()
                }
//                cell.removeClosure = {
//                    if cell.btnFav.imageView?.image == UIImage(named: "fav"){
//                        cell.btnFav.setImage(UIImage(named: "notFav"), for: .normal)
//                    }
//                    else{
//                        cell.btnFav.setImage(UIImage(named: "fav"), for: .normal)
//
//                    }
//                    let dict = self.arrLatestWed?[indexPath.row]
//                    self.vendorId = dict?.id
//                    self.addWish(vendorId: dict?.id ?? 0)
//                }
            }
            return cell
        }
        else if sectioncount == 4{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SetCollectionCell", for: indexPath as IndexPath) as! SetCollectionCell
            
            let dict = arrPopularLoc?[indexPath.row]
            cell.lblCity.text = dict?.location?.city
            cell.lblNumber.text = "\(dict?.vendors ?? 0) Vendors"
            if let url = URL(string: "https://wed-advisor.com/images/\(dict?.location?.logo ?? "")") {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    DispatchQueue.main.async { /// execute on main thread
                        cell.viewIMAGE.image = UIImage(data: data)
                    }
                }
                task.resume()
            }
            return cell
        }
        else if sectioncount == 5{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCollectionCell", for: indexPath as IndexPath) as! UpcomingCollectionCell
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
            let dict = arrHowItWork?[indexPath.row]
            let img = arrimg[indexPath.row]
            cell.imgName.text = dict?.header
            cell.imgImage.image = UIImage(named: img)
            return cell
            
        }
            
        else if sectioncount == 6{
            if checkForSix == "wedding tips and news"{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeddingAffairsCollectionCell", for: indexPath as IndexPath) as! WeddingAffairsCollectionCell
                let dict = arrGetWedding?[indexPath.row]
                cell.lblName.text = dict?.title
                cell.lblCity.text = dict?.description
                cell.lblRequest.text = "by \(dict?.author ?? "")"
                if let url = URL(string: "https://wed-advisor.com/images/\(dict?.cover_image ?? "")") {
                    let task = URLSession.shared.dataTask(with: url) { data, response, error in
                        guard let data = data, error == nil else { return }
                        
                        DispatchQueue.main.async { /// execute on main thread
                            cell.imgImage.image = UIImage(data: data)
                        }
                    }
                    
                    task.resume()
                }
                
                return cell
            }
            else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestimonialCell", for: indexPath as IndexPath) as! TestimonialCell
                let dict = arrTestimonial?[indexPath.row]
                cell.lblComment.text = dict?.comment
                cell.lblName.text = dict?.name
                cell.lblProfession.text = dict?.profession
                
                return cell
            }
        }
            
        else if sectioncount == 7{
            if checkforseven == "wedding tips and news"{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeddingAffairsCollectionCell", for: indexPath as IndexPath) as! WeddingAffairsCollectionCell
                let dict = arrGetWedding?[indexPath.row]
                cell.lblName.text = dict?.title
                cell.lblCity.text = dict?.description
                cell.lblRequest.text = "by \(dict?.author ?? "")"
                if let url = URL(string: "https://wed-advisor.com/images/\(dict?.cover_image ?? "")") {
                    let task = URLSession.shared.dataTask(with: url) { data, response, error in
                        guard let data = data, error == nil else { return }
                        
                        DispatchQueue.main.async { /// execute on main thread
                            cell.imgImage.image = UIImage(data: data)
                        }
                    }
                    
                    task.resume()
                }
                
                return cell
            }
            else{let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestimonialCell", for: indexPath as IndexPath) as! TestimonialCell
                let dict = arrTestimonial?[indexPath.row]
                cell.lblComment.text = dict?.comment
                cell.lblName.text = dict?.name
                cell.lblProfession.text = dict?.profession
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dict = arrItemList?[indexPath.row]
        if sectioncount == 1{
            if checkForOne == "featured vendors"{
                let dict = arrItemList?[indexPath.row]
                delegate?.getCell(index: 1, id: dict?.id ?? 0)
            }
            else{
                if indexPath.row == 5{
                    if checkForAllVendor == true{
                        delegate?.getCell(index: 2, id: dict?.id ?? 0)
                    }
                }
                else{
                    let dict = arrPopularCat?[indexPath.row]
                    delegate?.getCell(index: 5, id: dict?.id ?? 0)
                    
                }
                
            }
        }
        else if sectioncount == 2{
            if checkForTwo == "featured vendors"{
                let dict = arrItemList?[indexPath.row]
                delegate?.getCell(index: 1, id: dict?.id ?? 0)
            }
            else{
                if indexPath.row == 5{
                    if checkForAllVendor == true{
                        delegate?.getCell(index: 2, id: dict?.id ?? 0)
                    }
                }
                else{
                    let dict = arrPopularCat?[indexPath.row]
                    delegate?.getCell(index: 5, id: dict?.id ?? 0)
                }
                
            }
        }
            
        else if sectioncount == 3{
            let dict = arrLatestWed?[indexPath.row]
            delegate?.getCell(index: 1, id: dict?.id ?? 0)
        }
        else if sectioncount == 4{
            let dict = arrPopularLoc?[indexPath.row]
            delegate?.getCell(index: 4, id: dict?.location?.id ?? 0)
        }
        
        else if sectioncount == 6{
            let dict = arrGetWedding?[indexPath.row]
            if checkForSix == "wedding tips and news"{
                delegate?.getCell(index: 6, id: dict?.id ?? 0)

            }
        }
        
        else if sectioncount == 7{
            let dict = arrGetWedding?[indexPath.row]
            if checkforseven == "wedding tips and news"{
                delegate?.getCell(index: 6, id: dict?.id ?? 0)

            }
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if sectioncount == 1{
            if checkForOne == "featured vendors"{
                let size = (collectionData.frame.width) / 2.3
                let hgt = (collectionData.frame.height)
                return CGSize(width: size, height: hgt)
            }
            else{
                let size = (collectionData.frame.width) / 3
                let hgt = (collectionData.frame.height-10) / 2
                return CGSize(width: size, height: hgt)
            }
            
        }
        else if sectioncount == 2{
            if checkForTwo == "featured vendors"{
                let size = (collectionData.frame.width) / 2.3
                let hgt = (collectionData.frame.height)
                return CGSize(width: size, height: hgt)
            }
            else{
                let size = (collectionData.frame.width) / 3
                let hgt = (collectionData.frame.height-10) / 2
                return CGSize(width: size, height: hgt)
            }
            
        }
        else if sectioncount == 3{
            let size = (collectionData.frame.width) / 2.3
            let hgt = (collectionData.frame.height)
            return CGSize(width: size, height: hgt)
        }
        else if sectioncount == 4{
            let size = (collectionData.frame.width) / 3
            let hgt = (collectionData.frame.height) / 2
            return CGSize(width: size, height: hgt)
        }
        else if sectioncount == 5{
            let size = (collectionData.frame.width)/3
            let hgt = (collectionData.frame.height)
            return CGSize(width: size, height: hgt)
        }
        else if sectioncount == 6{
            if checkForSix == "wedding tips and news"{
                let size = (collectionData.frame.width)/1.2
                let hgt = (collectionData.frame.height)
                return CGSize(width: size, height: hgt)
            }
            else{
                let size = (collectionData.frame.width) / 1.3
                let hgt = (collectionData.frame.height-10)
                return CGSize(width: size, height: hgt)
            }
            
        }
        else if sectioncount == 7{
            if checkforseven == "wedding tips and news"{
                let size = (collectionData.frame.width)/1.2
                let hgt = (collectionData.frame.height)
                return CGSize(width: size, height: hgt)
            }
            else{
                let size = (collectionData.frame.width) / 1.3
                let hgt = (collectionData.frame.height-10)
                return CGSize(width: size, height: hgt)
            }
            
        }
        else{
            let size = (collectionData.frame.width) / 3
            let hgt = (collectionData.frame.height) / 2
            return CGSize(width: size, height: hgt)
            
        }
    }
    
}



extension HomeDataTableCell {
    
    func addWish(vendorId:Int) {
        let dictparam = ["product_id": vendorId ?? 0
            ] as [String:Any]
        
        //    self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.addWishList(with: dictparam, success: { (dataRemove) in
            //self.hideActivityIndicator(uiView: self.view)
            print(dataRemove.status)
            if dataRemove.status == 200{
            }
            else if dataRemove.status == 201{
            }
        }){ (error) in
            // self.hideActivityIndicator(uiView: self.view)
        }
    }
    
}
