//
//  VendorProductDetailController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 14/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class VendorProductDetailController: UIViewController {
    
    
    @IBOutlet weak var hotelNameLbl: UILabel!
    @IBOutlet weak var starCountLbl: UILabel!
    @IBOutlet weak var countryNameLbl: UILabel!
    @IBOutlet weak var hotelInfoLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var reviewCountLbl: UILabel!
    @IBOutlet weak var starView: UIView!
    @IBOutlet weak var optionSelectionView: UIView!
    @IBOutlet weak var reviewBtn: UIButton!
    @IBOutlet weak var aboutBtn: UIButton!
    @IBOutlet weak var gallaryBtn: UIButton!
    @IBOutlet weak var aboutTbl:UITableView!
    @IBOutlet weak var aboutContainerView: UIView!
    @IBOutlet weak var reviewTbl:UITableView!
    @IBOutlet weak var reviewContainerView: UIView!
    @IBOutlet weak var lblHotelName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var tblFAQ: UITableView!
    @IBOutlet weak var imgFAQ: UIImageView!
    @IBOutlet weak var heightFAQ: NSLayoutConstraint!
    @IBOutlet weak var heighttblFAQ: NSLayoutConstraint!
    @IBOutlet weak var simillarvendorCollection: UICollectionView!
    @IBOutlet weak var collectionAminity: UICollectionView!
    @IBOutlet weak var heightAminity: NSLayoutConstraint!
    @IBOutlet weak var heightCollectionAminity: NSLayoutConstraint!
    @IBOutlet weak var imgAminity: UIImageView!
    @IBOutlet weak var imgBackProfile: UIImageView!
    @IBOutlet weak var heightCompleteView: NSLayoutConstraint!
    @IBOutlet weak var heightDesc: NSLayoutConstraint!
    @IBOutlet weak var heightLblDesc: NSLayoutConstraint!
    @IBOutlet weak var heightD: NSLayoutConstraint!
    @IBOutlet weak var viewDesc: SwiftShadowImageView!
    @IBOutlet weak var viewFaq: SwiftShadowImageView!
    @IBOutlet weak var viewAminity: SwiftShadowImageView!
    @IBOutlet weak var heightTopSimillar: NSLayoutConstraint!
    
    @IBOutlet weak var viewReview: UIView!
    @IBOutlet weak var viewReviewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewGallery: UIView!
    @IBOutlet weak var viewGalleryHeight: NSLayoutConstraint!
    @IBOutlet weak var galleryTopHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionGallery: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var screenSize: CGRect!
    let dataModel = [1,4,5]
    var vendorId : Int?
    var desc: String?
    var itemlist: [HomeItemList]?
    var hotelName : String?
    var countryName : String?
    var rating: String?
    var Review : String?
    var arrAmnities : [amenitiesData]?
    var arrVendorAmnities : [amenitiesData]?
    var arrQAns : [VedorDetailQuestionsAns]?
    var showQuestoin = true
    var showAminities = true
    var arrData = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibs()
        addBlurToButton()
        heightFAQ.constant = 50
        tblFAQ.isHidden = true
        heighttblFAQ.constant = 0
        collectionAminity.isHidden = true
        heightAminity.constant = 50
        heightCollectionAminity.constant = 0
        viewReview.isHidden = true
        viewReviewHeight.constant = 0
        viewGallery.isHidden = true
        viewGalleryHeight.constant = 0
        
        print(vendorId)
        self.design()

        let statusBar1 =  UIView()
        statusBar1.frame = UIApplication.shared.statusBarFrame
        statusBar1.backgroundColor = WedAdviserColor.themeOrangeColor()
        UIApplication.shared.keyWindow?.addSubview(statusBar1)
        self.setNeedsStatusBarAppearanceUpdate()
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        simillarvendorCollection.delegate = self
        simillarvendorCollection.dataSource = self
        let layout1: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout1.scrollDirection = .horizontal
        layout1.itemSize = CGSize(width: screenWidth/2, height: 240)
        layout1.minimumInteritemSpacing = 0
        layout1.minimumLineSpacing = 0
        simillarvendorCollection!.collectionViewLayout = layout1
        collectionAminity.delegate = self
        collectionAminity.dataSource = self
        screenWidth = screenSize.width-50
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: screenWidth/2, height: screenHeight/20)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionAminity!.collectionViewLayout = layout
        let layoutgallery: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layoutgallery.scrollDirection = .vertical
        layoutgallery.itemSize = CGSize(width: screenWidth/2, height: collectionGallery.frame.size.height)
        layoutgallery.minimumInteritemSpacing = 0
        layoutgallery.minimumLineSpacing = 0
        collectionGallery!.collectionViewLayout = layoutgallery
        vendorData()
    }
    
    fileprivate func addBlurToButton() {
        blurView.effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        backButton.backgroundColor = .clear
        backButton.layer.cornerRadius = 20
        backButton.clipsToBounds = true
        blurView.layer.cornerRadius = 20
        blurView.clipsToBounds = true
    }
    
    
    func registerNibs(){
        simillarvendorCollection.register(UINib.init(nibName: "VendorHomeCollectionCell", bundle: nil), forCellWithReuseIdentifier: "VendorHomeCollectionCell")
        collectionAminity.register(UINib.init(nibName: "AmenitiesCell", bundle: nil), forCellWithReuseIdentifier: "AmenitiesCell")
    collectionGallery.register(UINib.init(nibName: "GallaryCell", bundle: nil), forCellWithReuseIdentifier: "GallaryCell")
        
    }
    
    func design(){
        self.starView.layer.borderColor = WedAdviserColor.starViewBorderColor().cgColor
        
        optionSelectionView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.aboutBtn.backgroundColor = WedAdviserColor.buttonselectBackgroundColor()
        self.reviewBtn.backgroundColor = WedAdviserColor.buttonUnselectBackgroundColor()
        self.gallaryBtn.backgroundColor = WedAdviserColor.buttonUnselectBackgroundColor()
    }
    
    @IBAction func backBtn(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func morePriceInfoBtnTapped(sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PriceInfoController") as? PriceInfoController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func AboutBtnTapped(sender: UIButton) {
        aboutContainerView.isHidden = false
        reviewContainerView.isHidden = true
        //        gallaryContainerView.isHidden = true
        self.aboutBtn.backgroundColor = WedAdviserColor.buttonselectBackgroundColor()
        self.reviewBtn.backgroundColor = WedAdviserColor.buttonUnselectBackgroundColor()
        self.gallaryBtn.backgroundColor = WedAdviserColor.buttonUnselectBackgroundColor()
        aboutBtn.setTitleColor(WedAdviserColor.buttonTextSelectionColor(), for: .normal)
        reviewBtn.setTitleColor(WedAdviserColor.buttonTextUnSelectColor(), for: .normal)
        gallaryBtn.setTitleColor(WedAdviserColor.buttonTextUnSelectColor(), for: .normal)
        
        heightFAQ.constant = 50
        tblFAQ.isHidden = true
        heighttblFAQ.constant = 0
        collectionAminity.isHidden = true
        heightAminity.constant = 50
        heightCollectionAminity.constant = 0
        heightTopSimillar.constant = 10
        viewDesc.isHidden = false
        viewReview.isHidden = true
        viewReviewHeight.constant = 0
        viewGallery.isHidden = true
        viewGalleryHeight.constant = 0
        galleryTopHeight.constant = 10
        viewFaq.isHidden = false
        viewAminity.isHidden = false

    }
    
    @IBAction func reviewBtnTapped(sender: UIButton) {
        aboutContainerView.isHidden = true
        reviewContainerView.isHidden = false
        //  gallaryContainerView.isHidden = true
        self.reviewBtn.backgroundColor = WedAdviserColor.buttonselectBackgroundColor()
        self.aboutBtn.backgroundColor = WedAdviserColor.buttonUnselectBackgroundColor()
        self.gallaryBtn.backgroundColor = WedAdviserColor.buttonUnselectBackgroundColor()
        reviewBtn.setTitleColor(WedAdviserColor.buttonTextSelectionColor(), for: .normal)
        aboutBtn.setTitleColor(WedAdviserColor.buttonTextUnSelectColor(), for: .normal)
        gallaryBtn.setTitleColor(WedAdviserColor.buttonTextUnSelectColor(), for: .normal)
    }
    
    @IBAction func GallaryBtnTapped(sender: UIButton) {
        aboutContainerView.isHidden = false
        reviewContainerView.isHidden = true
        //gallaryContainerView.isHidden = true
        self.gallaryBtn.backgroundColor = WedAdviserColor.buttonselectBackgroundColor()
        self.reviewBtn.backgroundColor = WedAdviserColor.buttonUnselectBackgroundColor()
        self.aboutBtn.backgroundColor = WedAdviserColor.buttonUnselectBackgroundColor()
        reviewBtn.setTitleColor(WedAdviserColor.buttonTextUnSelectColor(), for: .normal)
        aboutBtn.setTitleColor(WedAdviserColor.buttonTextUnSelectColor(), for: .normal)
        gallaryBtn.setTitleColor(WedAdviserColor.buttonTextSelectionColor(), for: .normal)
        heightAminity.constant = 0
        heightFAQ.constant = 0
        heightDesc.constant = 0
        heightLblDesc.constant = 0
        heightD.constant = 0
        viewDesc.isHidden = true
        print(lblDesc.calculateMaxLines())
        viewFaq.isHidden = true
        
        let a = 11 * lblDesc.calculateMaxLines()
        let b = a + 100
        galleryTopHeight.constant = galleryTopHeight.constant - CGFloat(b)
        connfigCollectionNotHeightGallery()
        viewGallery.isHidden = false
        viewAminity.isHidden = true
    }
    
    @IBAction func sendMessageBtnTapped(sender: UIButton) {
        
    }
    
    @IBAction func contactUsBtnTapped(sender: UIButton) {
        
    }
    
    
    @IBAction func writeReviewBtnTapped(_ sender: UIButton) {
        let nVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReviewPopupController") as! ReviewPopupController
        self.view.addSubview(nVC.view)
        nVC.view.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
        addChild(nVC)
        didMove(toParent: self)
    }
    
    @IBAction func btnFaq(_ sender: Any) {
        if(showQuestoin == true)
        {
            showQuestoin = false
            imgFAQ.image = #imageLiteral(resourceName: "upArrow")
            if arrQAns?.count != 0{
                tblFAQ.isHidden = false
                self.connfigCollectionNotHeight()
            }
            else{
                tblFAQ.isHidden = true
                heighttblFAQ.constant = 0
                heightFAQ.constant = 50
            }
        }
        else
        {
            showQuestoin = true
            imgFAQ.image = #imageLiteral(resourceName: "downArrow")
            tblFAQ.isHidden = true
            heighttblFAQ.constant = 0
            heightFAQ.constant = 50
            
        }
    }
    
    @IBAction func btnAmenity(_ sender: Any) {
        if(showAminities == true)
        {
            showAminities = false
            imgAminity.image = #imageLiteral(resourceName: "upArrow")
            if arrAmnities?.count != 0{
                collectionAminity.isHidden = false
                self.connfigCollectionAminitiesHeight()
            }
            else{
                collectionAminity.isHidden = true
                heightCollectionAminity.constant = 0
                heightAminity.constant = 50
            }
        }
        else
        {
            showAminities = true
            imgAminity.image = #imageLiteral(resourceName: "downArrow")
            collectionAminity.isHidden = true
            heightCollectionAminity.constant = 0
            heightAminity.constant = 50
            
        }
    }
    func connfigCollectionNotHeightGallery(){
        if arrData.count == 0{
            let numberOfLines = arrData.count
            viewGalleryHeight.constant = CGFloat(47*numberOfLines)
           // heightFAQ.constant = CGFloat(52*numberOfLines)
            collectionGallery.reloadData()
        }
        else{
            let numberOfLines = arrData.count/1+1
            viewGalleryHeight.constant = CGFloat(47*numberOfLines)
            //heightFAQ.constant = CGFloat(52*numberOfLines)
            collectionGallery.reloadData()
        }
    }
    
    func connfigCollectionNotHeight(){
        if arrQAns?.count == 0{
            let numberOfLines = arrQAns?.count ?? 0
            heighttblFAQ.constant = CGFloat(50*numberOfLines)
            heightFAQ.constant = CGFloat(52*numberOfLines)
            tblFAQ.reloadData()
        }
        else{
            let numberOfLines = arrQAns?.count ?? 0/1+1
            heighttblFAQ.constant = CGFloat(50*numberOfLines)
            heightFAQ.constant = CGFloat(52*numberOfLines)
            tblFAQ.reloadData()
        }
    }
    
    func connfigCollectionAminitiesHeight(){
        if arrAmnities?.count == 0{
            let numberOfLines = arrAmnities?.count ?? 0
            heightCollectionAminity.constant = CGFloat(30*numberOfLines)
            heightAminity.constant = CGFloat(18.5*Double(numberOfLines))
            collectionAminity.reloadData()
        }
        else{
            let numberOfLines = arrAmnities?.count ?? 0/1+1
            heightCollectionAminity.constant = CGFloat(30*numberOfLines)
            heightAminity.constant = CGFloat(18.5*Double(numberOfLines))
            collectionAminity.reloadData()
        }
    }
    
}


extension VendorProductDetailController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblFAQ{
            return arrQAns?.count ?? 0
        }else{
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblFAQ{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FaqTableCell", for: indexPath) as! FaqTableCell
            let dict = arrQAns?[indexPath.row]
            cell.lblQues.text = dict?.vendorquestion?.question
            cell.lblAns.text = dict?.answere_q
            return cell
        }
        
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblFAQ{
            return 50
        }
        else {
            return 200
        }
    }
    
}

extension VendorProductDetailController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == simillarvendorCollection{
            return itemlist?.count ?? 0
            
        }
        else if collectionView == collectionAminity{
            return arrAmnities?.count ?? 0
        }
        else{
            return arrData.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == simillarvendorCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VendorHomeCollectionCell", for: indexPath as IndexPath) as! VendorHomeCollectionCell
            if let dict = itemlist?[indexPath.row]{
                cell.lblVendorName.text = dict.name
                cell.lblCity.text = "\(dict.state ?? "")"
                cell.lblDay.text = "₹\(dict.base_price ?? 0) \(dict.base_price_unit ?? "")"
                if let url = URL(string: "https://wed-advisor.com/images/\(dict.profile_image ?? "vendor-img-1.jpg")") {
                    let task = URLSession.shared.dataTask(with: url) { data, response, error in
                        guard let data = data, error == nil else { return }
                        
                        DispatchQueue.main.async { /// execute on main thread
                            cell.imgVendor.image = UIImage(data: data)
                        }
                    }
                    
                    task.resume()
                }
                //      cell.imgVendor.sd_setImage(with: URL(string: "https://wed-advisor.com/images/vendor-img-1.jpg"), placeholderImage: UIImage(named: "placeholder.png"))
                if dict.is_wishlist == true{
                    cell.btnFav.setImage(UIImage(named: "fav"), for: .normal)
                }
                else{
                    cell.btnFav.setImage(UIImage(named: "notFav"), for: .normal)
                    
                }
//                cell.removeClosure = {
//                    if cell.btnFav.currentImage == UIImage(named: "fav"){
//                        cell.btnFav.setImage(UIImage(named: "notFav"), for: .normal)
//                    }
//                    else if cell.btnFav.currentImage == UIImage(named: "notFav"){
//                        cell.btnFav.setImage(UIImage(named: "fav"), for: .normal)
//                    }
//                    let dict = self.itemlist?[indexPath.row]
//                    self.addWish(vendorId: dict?.id ?? 0)
//                }
            }
            return cell
        }
        else if collectionView == collectionAminity{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AmenitiesCell", for: indexPath) as! AmenitiesCell
            let dict = arrAmnities?[indexPath.row]
            if arrVendorAmnities?.count != 0{
                let dictVendor = arrVendorAmnities?[indexPath.row]
                cell.lblAminity.text = dict?.amenities_option
                if dict?.id == dictVendor?.amenities_id{
                    if dictVendor?.status == "1"{
                        cell.imgEminity.image = #imageLiteral(resourceName: "checlright")
                    }
                    else{
                        cell.imgEminity.image = #imageLiteral(resourceName: "ic_crossRedCircle")
                        
                    }
                }
            }

            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GallaryCell", for: indexPath) as! GallaryCell
            let dict = arrData[indexPath.row]
            print(arrData.count)
            // cell.gallaryImage.image = UIImage(named: "\(dataModel[indexPath.row]).jpg")
            cell.gallaryImage.sd_setImage(with: URL(string: "\(dict)"), placeholderImage: UIImage(named: "fav.png"))
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 15
            return cell
        }
        return UICollectionViewCell()
        
        // }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == simillarvendorCollection{
            let vc = storyboard?.instantiateViewController(identifier: "VendorProductDetailController") as? VendorProductDetailController
            let dict = itemlist?[indexPath.row]
            vc?.vendorId = dict?.id
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
}

extension VendorProductDetailController{
    func vendorData()
    {
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
            self.lblHotelName.text = vendorData.vendor?.name
            self.lblDesc.text = vendorData.vendor?.notes?.html2String
            self.hotelNameLbl.text = vendorData.vendor?.name
            self.countryNameLbl.text = vendorData.vendor?.getcity?.city
            self.priceLbl.text = "₹ \(vendorData.vendor?.base_price ?? 0)"
            self.reviewCountLbl.text = "\(vendorData.vendor?.count_user_review ?? 0) Reviews"
            self.starCountLbl.text = "\(vendorData.vendor?.avg_rating ?? 0)"
            self.tblFAQ.dataSource = self
            self.tblFAQ.delegate = self
            self.arrQAns = vendorData.vendorQuestions
            self.itemlist = vendorData.similarVendors
            self.arrAmnities = vendorData.amenities
            self.arrVendorAmnities = vendorData.vendorAmenities
            if let url = URL(string: "https://wed-advisor.com/images/\(vendorData.vendor?.profile_image ?? "vendor-img-1.jpg")") {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    DispatchQueue.main.async { /// execute on main thread
                        self.imgBackProfile.image = UIImage(data: data)
                    }
                }
                
                task.resume()
            }
            
            
            if let img = vendorData.vendor_slider_imgs{
                for i in img{
                    let a = "https://wed-advisor.com/images/\(i.image ?? "wsYzMUI5v9679AgztTWt9m0z89kTaOsCPTLTYNmo.jpg")"
                    self.arrData.append(a)
                }
            }
            // print(self.arrQAns)
            self.tblFAQ.reloadData()
            self.simillarvendorCollection.reloadData()
            self.collectionAminity.reloadData()
            self.collectionGallery.reloadData()
        }){ (error) in
            self.hideActivityIndicator(uiView: self.view)
            
            // SupportMethod.showAlertMessage(messageStr: "Try Again")
        }
    }
}
extension VendorProductDetailController{
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
extension UILabel {
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}
