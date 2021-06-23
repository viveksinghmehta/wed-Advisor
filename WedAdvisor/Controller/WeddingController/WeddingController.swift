//
//  WeddingController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 27/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class WeddingController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var weddingCollection: UICollectionView!
       
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
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        weddingCollection!.collectionViewLayout = layout

        // Do any additional setup after loading the view.
    }
    
    // MARK:- Register cell
        func registerNibs(){
            weddingCollection.register(UINib.init(nibName: "WeddingCell", bundle: nil), forCellWithReuseIdentifier: "WeddingCell")
            
        }
    
    @IBAction func backBtn(sender: UIButton){
          self.navigationController?.popViewController(animated: true)
      }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = weddingCollection.dequeueReusableCell(withReuseIdentifier: "WeddingCell", for: indexPath as IndexPath) as! WeddingCell
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (weddingCollection.frame.width) / 1.1
        let hgt = (weddingCollection.frame.height-20)
        return CGSize(width: size, height: hgt)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "WeddingDetailController") as? WeddingDetailController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    

}

