//
//  BlogListController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 15/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class BlogListController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var blogTbl: UITableView!
    @IBOutlet weak var heightTable: NSLayoutConstraint!
    @IBOutlet weak var collectionSimillar: UICollectionView!
    @IBOutlet weak var collectionCategory: UICollectionView!

    var arrblogList : [GetweddTipsNews]?
    var arrDara = [Data]()
    var arrGetWedding : [GetweddTipsNews]?
    var arrCategory = [BlogDetailCategories]()

    var screenWidth: CGFloat!
         var screenHeight: CGFloat!
         var screenSize: CGRect!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        blogData()
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
               layout.scrollDirection = .horizontal
               layout.itemSize = CGSize(width: screenWidth/2, height: 240)
               layout.minimumInteritemSpacing = 0
               layout.minimumLineSpacing = 0
        collectionSimillar!.collectionViewLayout = layout
    }
    
    // MARK:- Register cell
    func registerNibs(){
        let categories = UINib(nibName: "BlogListCell" , bundle: nil)
        blogTbl.register(categories, forCellReuseIdentifier: "BlogListCell")
       
        collectionSimillar.register(UINib.init(nibName: "WeddingAffairsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "WeddingAffairsCollectionCell")
        collectionCategory.register(UINib.init(nibName: "BlogDetailCategory", bundle: nil), forCellWithReuseIdentifier: "BlogDetailCategory")

    }
    
    @IBAction func backBtn(sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionSimillar{
            return  arrGetWedding?.count ?? 0

        }
        else{
            return arrCategory.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionSimillar{
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeddingAffairsCollectionCell", for: indexPath as IndexPath) as! WeddingAffairsCollectionCell
            print(arrGetWedding)
              
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

        
    }
    
    
    // MARK:- Tableview Height
    func connfigCollectionHeight(){
        if arrblogList?.count == 0{
            let numberOfLines = arrblogList?.count ?? 0
            heightTable.constant = CGFloat(250*numberOfLines)
            blogTbl.reloadData()
        }
        else{
            let numberOfLines = arrblogList?.count ?? 0/1+1
            heightTable.constant = CGFloat(250*numberOfLines)
            blogTbl.reloadData()
        }
    }
    
}

extension BlogListController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlogListCell", for: indexPath) as! BlogListCell
        let dict = arrblogList?[indexPath.row]
        cell.lblBlogName.text = dict?.title
        cell.lblBlogList.text = dict?.description
        cell.imgBlog.sd_setImage(with: URL(string: "https://wed-advisor.com/images/\(dict?.cover_image ?? "")"), placeholderImage: UIImage(named: "placeholder.png"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BlogDetailController") as? BlogDetailController
        let dict = arrblogList?[indexPath.row]
        vc?.arrblogList = dict
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
extension BlogListController{
    func blogData()
    {
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.blogListing(success: { (blogData) in
            self.collectionSimillar.delegate = self
            self.collectionSimillar.dataSource = self
            self.hideActivityIndicator(uiView: self.view)
            self.arrblogList = blogData.blogs?.data
            self.arrGetWedding = blogData.recentBlogs
            if let arrCategory = blogData.blogCategories{
                self.arrCategory = arrCategory
            }
            if let img = blogData.blogs?.data{
                for i in img{
                    let a = "https://wed-advisor.com/images/\(i.cover_image ?? "")"
                    if let url = URL(string: a) {
                        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                            guard let data = data, error == nil else { return }
                            DispatchQueue.main.async { /// execute on main thread
                                self.arrDara.append(data)
                                self.blogTbl.reloadData()
                            }
                        }
                        task.resume()
                    }
                }
            }
           
            self.blogTbl.reloadData()
            self.collectionCategory.reloadData()
            self.collectionSimillar.reloadData()
            self.connfigCollectionHeight()
        }){ (error) in
            self.hideActivityIndicator(uiView: self.view)
            
            // SupportMethod.showAlertMessage(messageStr: "Try Again")
        }
    }
    
}
