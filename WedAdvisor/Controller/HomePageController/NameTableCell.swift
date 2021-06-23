//
//  NameTableCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandy on 14/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class NameTableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var heightHeader: NSLayoutConstraint!
    @IBOutlet weak var collectionNames: UICollectionView!
    @IBOutlet weak var viewHeader: UIView!
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var sectioncount: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionNames.dataSource = self
        collectionNames.delegate = self
        registerNibs()
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width-30
        screenHeight = screenSize.height
       
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // Register Nib
    func registerNibs(){
        collectionNames.register(UINib.init(nibName: "NameCollectionCell", bundle: nil), forCellWithReuseIdentifier: "NameCollectionCell")
        collectionNames.register(UINib.init(nibName: "UpcomingCollectionCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingCollectionCell")
        collectionNames.register(UINib.init(nibName: "WeddingAffairsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "WeddingAffairsCollectionCell")
        collectionNames.register(UINib.init(nibName: "SetCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SetCollectionCell")
        collectionNames.register(UINib.init(nibName: "ArrangeCategoryCell", bundle: nil), forCellWithReuseIdentifier: "ArrangeCategoryCell")
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if sectioncount == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NameCollectionCell", for: indexPath as IndexPath) as! NameCollectionCell
            
            viewHeader.isHidden = true
            heightHeader.constant = 0
            return cell
        }
        else if sectioncount == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCollectionCell", for: indexPath as IndexPath) as! UpcomingCollectionCell
            viewHeader.isHidden = false
            heightHeader.constant = 50
            return cell
            
        }
        
        else if sectioncount == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeddingAffairsCollectionCell", for: indexPath as IndexPath) as! WeddingAffairsCollectionCell
            viewHeader.isHidden = false
            heightHeader.constant = 50
            return cell
            
        }
        
        else if sectioncount == 3{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SetCollectionCell", for: indexPath as IndexPath) as! SetCollectionCell
            viewHeader.isHidden = false
            heightHeader.constant = 50
            return cell
            
        }
        
        else if sectioncount == 4{
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArrangeCategoryCell", for: indexPath as IndexPath) as! ArrangeCategoryCell
                   viewHeader.isHidden = true
                   heightHeader.constant = 0
                   return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    
}
