//
//  RealWeddingController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 22/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class RealWeddingController: UIViewController {

    @IBOutlet weak var UploadWeddingImageCollection: UICollectionView!
    
    var screenSize: CGRect!
       var screenWidth: CGFloat!
       var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width - 66
        screenHeight = screenSize.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth/3, height: 100)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        UploadWeddingImageCollection!.collectionViewLayout = layout
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    

}

extension RealWeddingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UploadWeddingImageCollection.dequeueReusableCell(withReuseIdentifier: "RealWeddingUploadGallaryCell", for: indexPath as IndexPath) as! RealWeddingUploadGallaryCell
        return cell
    
}
}
