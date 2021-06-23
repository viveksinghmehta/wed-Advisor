//
//  GallaryController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 18/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class GallaryController: UIViewController {
    
    
    @IBOutlet weak var gallaryCollectionView: UICollectionView!
    
    // let dataModel = [GalleryData]
    var arrData = [String]()
    var imgData = [Data]()
    var pageNo:Int=1
    var nextPage : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerNibs()
        
        //        if let layout = gallaryCollectionView.collectionViewLayout as? PinterestLayout{
        //            layout.delegate = self
        //        }
        gallaryCollectionView.showsVerticalScrollIndicator = false
        
        let statusBar1 =  UIView()
        statusBar1.frame = UIApplication.shared.statusBarFrame
        statusBar1.backgroundColor = WedAdviserColor.themeOrangeColor()
        UIApplication.shared.keyWindow?.addSubview(statusBar1)
        self.setNeedsStatusBarAppearanceUpdate()
        
        GalleryData()
    }
    
    // MARK:- Register cell
    func registerNibs(){
        gallaryCollectionView.register(UINib.init(nibName: "GallaryCell", bundle: nil), forCellWithReuseIdentifier: "GallaryCell")
        
        
    }
    
    @IBAction func backBtn(sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}

extension GallaryController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(arrData.count)
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gallaryCollectionView.dequeueReusableCell(withReuseIdentifier: "GallaryCell", for: indexPath as IndexPath) as! GallaryCell
        let dict = arrData[indexPath.row]
        print(arrData.count)
        // cell.gallaryImage.image = UIImage(named: "\(dataModel[indexPath.row]).jpg")
        cell.gallaryImage.sd_setImage(with: URL(string: "\(dict)"), placeholderImage: UIImage(named: "fav.png"))
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 15
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == arrData.count-1) {
            if nextPage != "" && nextPage != nil{
                pageNo = pageNo + 1
                GalleryData()
            }
            
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let dict = arrData[indexPath.row]
        if dict != "" && dict != nil{
            let url = URL(string: "\(dict)")!
            let data = (try? Data(contentsOf: url))!
            let image = UIImage(data: data)
            
            if image != nil{
                let height = (image?.size.height)!
                let newheight = height/4
                
                print(newheight)
                if newheight > 1000{
                    return CGSize(width: (gallaryCollectionView.bounds.size.width-10)/2, height: (height-newheight))
                }
//                else if newheight > 600{
//                    return CGSize(width: (gallaryCollectionView.bounds.size.width-10)/2, height: (height-newheight)/3)
//                }
//                else if newheight > 330{
//                    return CGSize(width: (gallaryCollectionView.bounds.size.width-10)/2, height: (height-newheight)/4)
//                }
//                else if newheight > 300{
//                    return CGSize(width: (gallaryCollectionView.bounds.size.width-10)/2, height: (height-newheight)/3)
//                }
//
                else if newheight > 270{
                    return CGSize(width: (gallaryCollectionView.bounds.size.width-10)/2, height: 200)
                }
//                else if newheight > 220{
//                    return CGSize(width: (gallaryCollectionView.bounds.size.width-10)/2, height: (height-newheight)/3.8)
//                }
//                else if newheight > 200{
//                    return CGSize(width: (gallaryCollectionView.bounds.size.width-10)/2, height: (height-newheight)/3)
//                }
//                else if newheight > 150{
//                    return CGSize(width: (gallaryCollectionView.bounds.size.width-10)/2, height: (height-newheight)/2)
//                }
//                else if newheight > 130{
//                    return CGSize(width: (gallaryCollectionView.bounds.size.width-10)/2, height: (height-newheight)/2.5)
//                }
//                else if newheight > 110{
//                    return CGSize(width: (gallaryCollectionView.bounds.size.width-10)/2, height: (height-newheight)/3)
//                }
//                else if newheight > 102{
//                    return CGSize(width: (gallaryCollectionView.bounds.size.width-10)/2, height: (height-newheight)/1.5)
//                }
//                else if newheight > 100{
//                    return CGSize(width: (gallaryCollectionView.bounds.size.width-10)/2, height: (height-newheight))
//                }
//                else if newheight > 50{
//                    return CGSize(width: (gallaryCollectionView.bounds.size.width-10)/2, height: (height-newheight))
//                }
                else{
                    return CGSize(width: (gallaryCollectionView.bounds.size.width-10)/2, height: (height-newheight)/3)
                }
            }
            
        }
        return CGSize(width: 0, height: 0)
    }
    
}
extension GallaryController{
    func GalleryData()
    {
        self.showActivityIndicator(uiView: self.view)
        //https://wed-advisor.com/gallery?page=2
        let dictparam = ["page":pageNo] as [String:Any]
        APIManager.sharedInstance.galleryListing(with: dictparam, success: { (galleryData) in
            self.hideActivityIndicator(uiView: self.view)
            if let img = galleryData.gallery?.data{
                for i in img{
                    let a = "https://wed-advisor.com/images/\(i.image ?? "wsYzMUI5v9679AgztTWt9m0z89kTaOsCPTLTYNmo.jpg")"
                    self.arrData.append(a)
                }
            }
            self.nextPage = galleryData.gallery?.next_page_url
            print(self.nextPage)
            print(self.arrData)
            
            
            self.gallaryCollectionView.dataSource = self
            if let layout = self.gallaryCollectionView.collectionViewLayout as? PinterestLayout{
                //layout.delegate = self
                // layout. = PinterestLayoutDelegate
                //self.viewDidLoad()
            }
            self.gallaryCollectionView.reloadData()
            
        }){ (error) in
            self.hideActivityIndicator(uiView: self.view)
            
        }
    }
}
