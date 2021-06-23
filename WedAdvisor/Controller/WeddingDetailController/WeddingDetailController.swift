//
//  WeddingDetailController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 20/02/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import Foundation

class WeddingDetailController: UIViewController {
    
    @IBOutlet weak var imgTop: UIImageView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var vendorUsedWishlistCollectionView: UICollectionView!

    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    let dataModel = [1,2,3,4,5,6,7,8]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibs()
        statusbarcolor()
//        screenSize = UIScreen.main.bounds
//        screenWidth = screenSize.width-20
//        screenHeight = screenSize.height
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: screenWidth-20, height: 510/2)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        layout.scrollDirection = .vertical
//        vendorUsedWishlistCollectionView!.collectionViewLayout = layout
//        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .vertical
//        flowLayout.minimumLineSpacing = 0
//        flowLayout.minimumInteritemSpacing = 0
//        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      //  imagesCollectionView!.collectionViewLayout = flowLayout

        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
//        if let layout = imagesCollectionView.collectionViewLayout as? PinterestLayout{
//            layout.delegate = self
//        }
        //imagesCollectionView.showsVerticalScrollIndicator = false
        
        
    }
    
    // MARK:- Register cell
    func registerNibs(){
        imagesCollectionView.register(UINib.init(nibName: "ArrangeCategoryCell", bundle: nil), forCellWithReuseIdentifier: "ArrangeCategoryCell")
        vendorUsedWishlistCollectionView.register(UINib.init(nibName: "MyWishListCell", bundle: nil), forCellWithReuseIdentifier: "MyWishListCell")

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
    
    
}

extension WeddingDetailController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imagesCollectionView{
            return dataModel.count
            
        }else{
            return 8
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == imagesCollectionView{
            let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "ArrangeCategoryCell", for: indexPath as IndexPath) as! ArrangeCategoryCell
            
//            cell.gallaryImage.image = UIImage(named: "\(dataModel[indexPath.row]).jpg")
//            cell.clipsToBounds = true
//            cell.layer.cornerRadius = 15
            
            return cell
        }else{
            let cell = vendorUsedWishlistCollectionView.dequeueReusableCell(withReuseIdentifier: "MyWishListCell", for: indexPath as IndexPath) as! MyWishListCell
            
            return cell
        }
        
        return UICollectionViewCell()
        
    }
//    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
//
//        if collectionView == imagesCollectionView{
//            let image = UIImage(named: "\(dataModel[indexPath.row]).jpg")
//            if let height = image?.size.height{
//                return height
//            }
//            return 0.0
//        }
//        return 0.0
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                if collectionView == imagesCollectionView{
                    if indexPath.row % 3 == 0{
                        let size = (imagesCollectionView.frame.width)
                        let hgt = (imagesCollectionView.frame.height) / 3
                        return CGSize(width: size, height: hgt)
                    }
                    else{
                        let size = (imagesCollectionView.frame.width) / 2
                        let hgt = (imagesCollectionView.frame.height) / 3
                         return CGSize(width: size, height: hgt)

                    }
        
                }
                else{
                    let size = (vendorUsedWishlistCollectionView.frame.width) / 5
                    let hgt = (vendorUsedWishlistCollectionView.frame.height)
                    return CGSize(width: size, height: hgt)
                }
    }
    

}
