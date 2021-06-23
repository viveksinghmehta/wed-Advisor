//
//  VendorProductController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 14/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class VendorProductController: UIViewController {
    
    @IBOutlet weak var vendorProductCollection: UICollectionView!
    @IBOutlet weak var txtSearch: UITextField!
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width-20
        screenHeight = screenSize.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth/2, height: 470/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        vendorProductCollection!.collectionViewLayout = layout
        
    }
    
    // MARK:- Register cell
    func registerNibs(){
        vendorProductCollection.register(UINib.init(nibName: "VendorProductCell", bundle: nil), forCellWithReuseIdentifier: "VendorProductCell")
        
    }
    
   @IBAction func backBtn(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func searchBtnTapped(sender: UIButton){
        
    }
    
    
}

extension VendorProductController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = vendorProductCollection.dequeueReusableCell(withReuseIdentifier: "VendorProductCell", for: indexPath as IndexPath) as! VendorProductCell
        return cell
        
    }
    
    
    
    
}
