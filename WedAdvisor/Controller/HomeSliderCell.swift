//
//  HomeSliderCell.swift
//  WedAdvisor
//

//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import ImageSlideshow

class HomeSliderCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var viewSlider: ImageSlideshow!
    @IBOutlet var collectionViewTopBanner: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    
    
    var timer = Timer()
    var counter = 0
    var bannerImages = [String]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()


        collectionViewTopBanner.layer.cornerRadius = 10
        pageView.numberOfPages = bannerImages.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
              self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
           }
        registerNibs()
    }
    
    // Register Nib
    func registerNibs() {
        collectionViewTopBanner.register(UINib.init(nibName: "CellAdvertisements", bundle: nil), forCellWithReuseIdentifier: "CellAdvertisements")
    }
    
    
    func imageWithImage (sourceImage:UIImage, scaledToWidth: CGFloat) -> UIImage {
        let oldWidth = sourceImage.size.width
        let scaleFactor = scaledToWidth / oldWidth

        let newHeight = sourceImage.size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor

        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
        sourceImage.draw(in: CGRect(x:0, y:0, width:newWidth, height:newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    //MARK:- Collectionview datasource & Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellAdvertisements", for: indexPath as IndexPath) as! CellAdvertisements
        let imageURL = URL(string: GlobalConstantClass.APIConstantNames.imageBaseURL + Helper.optionalStringToString(value: bannerImages[indexPath.row]))
        cell.imgImage.sd_setImage(with: imageURL, placeholderImage: UIImage(systemName: "slowmo"))
        cell.imgImage.tintColor = .gray
        cell.imgImage.contentMode = .scaleAspectFill
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionViewTopBanner.frame.width)
                   let hgt = (collectionViewTopBanner.frame.height)
                   return CGSize(width: size, height: hgt)
    }
    
    @objc func changeImage() {
             
         if counter < bannerImages.count {
              let index = IndexPath.init(item: counter, section: 0)
              self.collectionViewTopBanner.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
              pageView.currentPage = counter
              counter += 1
         } else {
              counter = 0
              let index = IndexPath.init(item: counter, section: 0)
              self.collectionViewTopBanner.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
               pageView.currentPage = counter
               counter = 1
           }
      }
    
}



