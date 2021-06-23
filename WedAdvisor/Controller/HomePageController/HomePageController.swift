//
//  HomePageController.swift
//  WedAdvisor
//
//  Created by Vishal Pandy on 14/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import ImageSlideshow

class HomePageController: UIViewController,selectMenu {
      
    
    @IBOutlet weak var viewSlider: ImageSlideshow!
    @IBOutlet weak var collectionCategory: UICollectionView!
    @IBOutlet weak var collectionPopular: UICollectionView!
    @IBOutlet weak var collectionFeature: UICollectionView!
    @IBOutlet weak var collectionBlog: UICollectionView!
    @IBOutlet weak var collectionReal: UICollectionView!
    
       var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var arrCategory = ["c1","c2","c3","c4","c5",""]
    var arrPopular = ["g1","g2","g3","g1","g2","g3"]
    var arrBlog = ["b1","b2","b3","b1","b2","b3"]
    var arrFeature = ["f1","f2","f3","f4","f5","f6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusbarcolor()
        
      setUP()
        
    }
    
    
    func setUP(){
       viewSlider.slideshowInterval = 5.0
        viewSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        viewSlider.contentScaleMode = UIViewContentMode.scaleToFill
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        viewSlider.pageIndicator = pageControl
        viewSlider.layer.cornerRadius = 15
        viewSlider.activityIndicator = DefaultActivityIndicator()
        viewSlider.delegate = self
        viewSlider.setImageInputs([
            ImageSource(image: UIImage(named: "slidet1")!),
            ImageSource(image: UIImage(named: "slider2")!),
            ImageSource(image: UIImage(named: "slider3")!)
        ])
        collectionCategory.dataSource = self
        collectionCategory.delegate = self
        collectionPopular.dataSource = self
        collectionPopular.delegate = self
        collectionFeature.dataSource = self
        collectionFeature.delegate = self
        collectionBlog.dataSource = self
        collectionBlog.delegate = self
        collectionReal.dataSource = self
        collectionReal.delegate = self
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0                //layout.scrollDirection = .vertical
        collectionFeature!.collectionViewLayout = layout
        let layouttwo: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layouttwo.minimumInteritemSpacing = 0
        layouttwo.minimumLineSpacing = 0
        layouttwo.scrollDirection = .horizontal
        collectionPopular!.collectionViewLayout = layouttwo
        let layoutthree: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layoutthree.minimumInteritemSpacing = 0
        layoutthree.minimumLineSpacing = 0
        layoutthree.scrollDirection = .horizontal
        collectionCategory!.collectionViewLayout = layoutthree
        let layoutfour: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layoutfour.minimumInteritemSpacing = 0
        layoutfour.minimumLineSpacing = 0
        layoutfour.scrollDirection = .horizontal
        collectionBlog!.collectionViewLayout = layoutfour
        let layoutfive: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layoutfive.minimumInteritemSpacing = 0
        layoutfive.minimumLineSpacing = 0
        layoutfive.scrollDirection = .horizontal
        collectionReal!.collectionViewLayout = layoutfive
        self.registerNibs()
    }
    
    // Status bar color
          func statusbarcolor(){
              let statusBar =  UIView()
                     statusBar.frame = UIApplication.shared.statusBarFrame
              statusBar.backgroundColor = WedAdviserColor.themeOrangeColor()
                     UIApplication.shared.keyWindow?.addSubview(statusBar)
          }
    
    // MARK:- Register cell
      // MARK:- Register cell
        func registerNibs(){
            collectionCategory.register(UINib.init(nibName: "CategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionCell")
            collectionPopular.register(UINib.init(nibName: "NameCollectionCell", bundle: nil), forCellWithReuseIdentifier: "NameCollectionCell")
            collectionFeature.register(UINib.init(nibName: "ArrangeCategoryCell", bundle: nil), forCellWithReuseIdentifier: "ArrangeCategoryCell")
            collectionBlog.register(UINib.init(nibName: "NameCollectionCell", bundle: nil), forCellWithReuseIdentifier: "NameCollectionCell")
            collectionReal.register(UINib.init(nibName: "WeddingAffairsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "WeddingAffairsCollectionCell")

        }
    
    @IBAction func locationBtnTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LocationController") as? LocationController
                   self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func profileBtnTapped(_ sender: Any) {
          let vc = storyboard?.instantiateViewController(withIdentifier: "SelectOptionsController") as? SelectOptionsController
                     self.navigationController?.pushViewController(vc!, animated: true)
      }
    
    @IBAction func btnMenu(_ sender: Any) {
             let vc = storyboard?.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
             vc.delegateMenu = self
             let transition = CATransition()
             transition.duration = 0.1
             // transition.type = CATransitionType.push
             transition.subtype = CATransitionSubtype.fromLeft
             transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
             view.window!.layer.add(transition, forKey: kCATransition)
             
             self.present(vc, animated: true, completion: nil)
             //self.navigationController?.present(vc, animated: true, completion: nil)
         }
    
    func selectMenuIndex(index: Int) {
            nextMenu(indexMenu: index)
        
        }
      

}
extension HomePageController: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
    }
}


extension HomePageController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionCategory{
            return 6
        }
        else if collectionView == collectionPopular{
            return  6
            
        }
        else if collectionView == collectionFeature{
            return 6
        }
        else if collectionView == collectionBlog {
            return 6
        }
        else{
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionCategory{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath as IndexPath) as! CategoryCollectionCell
            let dict = arrCategory[indexPath.row]
            cell.viewImage.image = UIImage(named: dict)
            return cell
        }
        else if collectionView == collectionPopular{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NameCollectionCell", for: indexPath as IndexPath) as! NameCollectionCell
            let dict = arrPopular[indexPath.row]
            cell.heightBack.constant = 160
            cell.lblPrice.isHidden = true
            cell.lblCityTwo.isHidden = true
            cell.lblName.isHidden = true
            cell.lblCity.isHidden = false
            cell.lblVendor.isHidden = false
            cell.imgName.image = UIImage(named: dict)
            return cell
        }
        else if collectionView == collectionFeature{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArrangeCategoryCell", for: indexPath as IndexPath) as! ArrangeCategoryCell
            let dict = arrFeature[indexPath.row]
            cell.imgImage.image = UIImage(named: dict)
            return cell
        }
        else if collectionView == collectionBlog{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NameCollectionCell", for: indexPath as IndexPath) as! NameCollectionCell
            cell.heightBack.constant = 140
            let dict = arrBlog[indexPath.row]
            cell.lblPrice.isHidden = false
            cell.lblCityTwo.isHidden = false
            cell.lblName.isHidden = false
            cell.lblCity.isHidden = true
            cell.lblVendor.isHidden = true
            cell.imgName.image = UIImage(named: dict)
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeddingAffairsCollectionCell", for: indexPath as IndexPath) as! WeddingAffairsCollectionCell
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionCategory{
            let size = (collectionCategory.frame.width) / 3
            let hgt = (collectionCategory.frame.height) / 2
            return CGSize(width: size, height: hgt)
        }
        else if collectionView == collectionPopular{
            let size = (screenWidth) / 1.2
            let hgt = (collectionPopular.frame.height)
            return CGSize(width: size, height: hgt)
        }
        else if collectionView == collectionFeature{
            let size = (collectionFeature.frame.width) / 3
            let hgt = (collectionFeature.frame.height) / 2
            return CGSize(width: size, height: hgt)
        }
        else if collectionView == collectionBlog{
            let size = (collectionBlog.frame.width) / 1.3
            let hgt = (collectionBlog.frame.height)
            return CGSize(width: size, height: hgt)
        }
        else{
            let size = (collectionReal.frame.width) / 1.2
            let hgt = (collectionReal.frame.height)
            return CGSize(width: size, height: hgt)
        }
    }
    
}
