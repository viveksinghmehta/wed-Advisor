//
//  BlogDetailController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 18/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class BlogDetailController: UIViewController {
    
    @IBOutlet weak var imgBlogDetail: UIImageView!
    @IBOutlet weak var blogDetailTitleLbl: UILabel!
    @IBOutlet weak var blogDetailDescriptionLbl: UILabel!
    @IBOutlet weak var weddingLbl: UILabel!
    @IBOutlet weak var weddingImgCollectionView: UICollectionView!
    @IBOutlet weak var heightRelatedPost: NSLayoutConstraint!
    @IBOutlet weak var heightRecentPost: NSLayoutConstraint!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var heightTable: NSLayoutConstraint!
    @IBOutlet weak var RecentCollection: UICollectionView!
    @IBOutlet weak var tblComment: UITableView!
    @IBOutlet weak var collectionCategory: UICollectionView!
    @IBOutlet weak var imgComment: UIImageView!
    @IBOutlet weak var lblNy: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    
    
    var arrblogList : GetweddTipsNews?
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    let dataModel = [1,2,3,4,5,6,7,8]
    var id : Int?
    var arrRelatedPost : [BlogDetail]?
    var arrRecentPost : [BlogDetail]?
    var showComment = true
    var arrComment : [CommentDetail]?
    var checkfromHome : Bool?
    var blogImg : BlogDetail?
    // var arrTabOptions = ["Venue", "Photographer", "Videographer", "Dress", "Florist"]
    var arrCategory = [BlogDetailCategories]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibs()
        print(id)
        statusbarcolor()
        imgBlogDetail.layer.cornerRadius = 10
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width-25
        screenHeight = screenSize.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth/2, height: 240)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        weddingImgCollectionView!.collectionViewLayout = layout
        let layouttwo: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layouttwo.itemSize = CGSize(width: screenWidth/2, height: 240)
        layouttwo.minimumInteritemSpacing = 0
        layouttwo.minimumLineSpacing = 0
        layouttwo.scrollDirection = .horizontal
        RecentCollection!.collectionViewLayout = layouttwo
        blogDetailTitleLbl.text = arrblogList?.title
        blogDetailDescriptionLbl.text = arrblogList?.description
        if checkfromHome == true{
            
        }
        else{
            id = arrblogList?.id
        }
        heightTable.constant = 0
        tblComment.isHidden = true
        blogData()
        
        txtMessage.layer.borderColor = UIColor.lightGray.cgColor
        txtMessage.layer.borderWidth = 1
        txtMessage.layer.cornerRadius = 10
        btnSubmit.layer.cornerRadius = 10
    }
    
    // MARK:- Register cell
    func registerNibs(){
        weddingImgCollectionView.register(UINib.init(nibName: "WeddingAffairsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "WeddingAffairsCollectionCell")
        RecentCollection.register(UINib.init(nibName: "WeddingAffairsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "WeddingAffairsCollectionCell")
        collectionCategory.register(UINib.init(nibName: "BlogDetailCategory", bundle: nil), forCellWithReuseIdentifier: "BlogDetailCategory")
        
    }
    
    // Status bar color
    func statusbarcolor(){
        let statusBar =  UIView()
        statusBar.frame = UIApplication.shared.statusBarFrame
        statusBar.backgroundColor = WedAdviserColor.themeOrangeColor()
        UIApplication.shared.keyWindow?.addSubview(statusBar)
    }
    
    @IBAction func backBtn(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func showCommentBtnTapped(button: UIButton) {
        if(showComment == true)
        {
            showComment = false
            imgComment.image = #imageLiteral(resourceName: "upArrow")
            if arrComment?.count != 0{
                tblComment.isHidden = false
                self.connfigTableHeight()
            }
            else{
                tblComment.isHidden = true
                heightTable.constant = 0
            }
        }
        else
        {
            showComment = true
            imgComment.image = #imageLiteral(resourceName: "downArrow")
            tblComment.isHidden = true
            heightTable.constant = 0
            
        }
    }
    
    // MARK:- Tableview Height
    func connfigCollectionHeight(){
        if arrRelatedPost?.count == 0{
            let numberOfLines = arrRelatedPost?.count ?? 0/2
            heightRelatedPost.constant = CGFloat(160*numberOfLines)
            weddingImgCollectionView.reloadData()
        }
        else{
            let numberOfLines = arrRelatedPost?.count ?? 0/2+1
            heightRelatedPost.constant = CGFloat(160*numberOfLines)
            weddingImgCollectionView.reloadData()
        }
    }
    func connfigTableHeight(){
        if arrComment?.count == 0{
            let numberOfLines = arrComment?.count ?? 0
            heightTable.constant = CGFloat(130*numberOfLines)
            tblComment.reloadData()
        }
        else{
            let numberOfLines = arrComment?.count ?? 0/1+1
            heightTable.constant = CGFloat(130*numberOfLines)
            print(heightTable.constant)
            tblComment.reloadData()
        }
    }
}

extension BlogDetailController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == weddingImgCollectionView{
            return arrRelatedPost?.count ?? 0
        }
        else if collectionView == RecentCollection{
            return arrRecentPost?.count ?? 0
        }
        else{
            return arrCategory.count
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == weddingImgCollectionView{
            let cell = weddingImgCollectionView.dequeueReusableCell(withReuseIdentifier: "WeddingAffairsCollectionCell", for: indexPath as IndexPath) as! WeddingAffairsCollectionCell
            let dict = arrRelatedPost?[indexPath.row]
            cell.lblName.text = dict?.title
            cell.lblCity.text = dict?.description
            cell.lblRequest.text = ""
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
        else if collectionView == RecentCollection{
            let cell = weddingImgCollectionView.dequeueReusableCell(withReuseIdentifier: "WeddingAffairsCollectionCell", for: indexPath as IndexPath) as! WeddingAffairsCollectionCell
            let dict = arrRecentPost?[indexPath.row]
            cell.lblName.text = dict?.title
            cell.lblCity.text = dict?.description
            cell.lblRequest.text = self.convertDateFormat(inputDate: dict?.created_at ?? "2021-01-13T02:23:13.000000Z")
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
            let cell = collectionCategory.dequeueReusableCell(withReuseIdentifier: "BlogDetailCategory", for: indexPath as IndexPath) as! BlogDetailCategory
            let dict = arrCategory[indexPath.row]
            cell.selectOptionsLbl.text = dict.name
            if indexPath.row == 0
            {
                collectionCategory.selectItem(at: indexPath, animated: true, scrollPosition: .right) //Add this line
                cell.isSelected = true
            }
            else{
                cell.isSelected = false
            }
            return cell
        }
        return UICollectionViewCell()
        
    }
    
}
extension BlogDetailController{
    func blogData()
    {
        self.showActivityIndicator(uiView: self.view)
        //https://wed-advisor.com/gallery?page=2
        let dictparam = ["id":id ?? 0] as [String:Any]
        APIManager.sharedInstance.blogDetails(with: dictparam, success: { (blogdetailData) in
            self.hideActivityIndicator(uiView: self.view)
            if let arrrelated = blogdetailData.relatedBolgs{
                self.arrRelatedPost = arrrelated
            }
            if let arrrecent = blogdetailData.recentBlogs{
                self.arrRecentPost = arrrecent
            }
            if let arrComents = blogdetailData.comments{
                self.arrComment = arrComents
            }
            if let arrCategory = blogdetailData.blogCategories{
                self.arrCategory = arrCategory
            }
            if let by = blogdetailData.blog?.author{
                self.lblNy.text = "By \(by)"
            }
            if let cmt = blogdetailData.blog?.total_comments{
                if cmt == 1{
                    self.lblComment.text = "\(cmt) Comment"
                    
                }
                else{
                    self.lblComment.text = "\(cmt) Comments"
                    
                }
            }
            
            if let date = blogdetailData.blog?.created_at{
                let a =  self.convertDateFormat(inputDate: date)
                print(a)
                self.lblDate.text = a
            }
            self.blogImg = blogdetailData.blog
            self.blogDetailTitleLbl.text = blogdetailData.blog?.title
           // self.lblNy.text = blogdetailData.blog?.author
            self.blogDetailDescriptionLbl.text = blogdetailData.blog?.description
         //   https://wed-advisor.com/images/post-img-1.jpg
            print(self.arrblogList?.cover_image)
            self.imgBlogDetail.sd_setImage(with: URL(string: "https://wed-advisor.com/images/\(self.blogImg?.cover_image ?? "")"), placeholderImage: UIImage(named: "placeholder.png"))

            self.connfigCollectionHeight()
            self.RecentCollection.reloadData()
            self.collectionCategory.reloadData()
        }){ (error) in
            self.hideActivityIndicator(uiView: self.view)
            
        }
    }
    
    
    func convertDateFormat(inputDate: String) -> String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000000Z"
        let oldDate = olDateFormatter.date(from: inputDate)
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "dd MMM , yyyy"
        return convertDateFormatter.string(from: oldDate!)
    }
}
extension BlogDetailController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  print(arrComment?.count)
        return arrComment?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlodCommentCellTableViewCell", for: indexPath) as! BlodCommentCellTableViewCell
        let dict = arrComment?[indexPath.row]
        cell.lblName.text = dict?.getuser?.name
        cell.lblComment.text = dict?.comment
        if let url = URL(string: "https://wed-advisor.com/images/\(dict?.getuser?.profile_image ?? "")") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async { /// execute on main thread
                    cell.imgPhoto.image = UIImage(data: data)
                }
            }
            task.resume()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
