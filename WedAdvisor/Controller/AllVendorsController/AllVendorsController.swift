//
//  AllVendorsController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 13/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

final class AllVendorsController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
     @IBOutlet weak var vendorsCollView: UICollectionView!
     @IBOutlet weak var collViewHeight: NSLayoutConstraint!
    var arrAllVendor : [HomeVendorType]?
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var screenSize: CGRect!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryCollDimension()
        registerNibs()
        vendorData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func backBtn(sender: UIButton) {
        self.tabBarController?.selectedIndex = 0
//          self.navigationController?.popViewController(animated: true)
      }
    
    func categoryCollDimension(){
        vendorsCollView.dataSource = self
        vendorsCollView.delegate = self
         screenSize = UIScreen.main.bounds
         screenWidth = screenSize.width-20
         screenHeight = screenSize.height
//         let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//         layout.scrollDirection = .vertical
//        layout.itemSize = CGSize(width: screenWidth/3, height: screenHeight/4)
//         layout.minimumInteritemSpacing = 0
//         layout.minimumLineSpacing = 0
//         vendorsCollView!.collectionViewLayout = layout
     }
    
    // MARK:- Register cell
       func registerNibs(){
           vendorsCollView.register(UINib.init(nibName: "AllVendorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AllVendorCollectionViewCell")
       }
    
    
    
    // Collection View Delegate & Datasource
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrAllVendor?.count ?? 0
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               let vendorCell = vendorsCollView.dequeueReusableCell(withReuseIdentifier: "AllVendorCollectionViewCell", for: indexPath) as! AllVendorCollectionViewCell
        
        let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
      //   let collectionView = UICollectionView(frame: f, collectionViewLayout: layout)
         let dict = arrAllVendor?[indexPath.row]
         vendorCell.lblName.text = dict?.name
         if let url = URL(string: "https://wed-advisor.com/images/popular_category/\(dict?.logo ?? "")") {
             let task = URLSession.shared.dataTask(with: url) { data, response, error in
                 guard let data = data, error == nil else { return }
                 
                 DispatchQueue.main.async { /// execute on main thread
                     vendorCell.imgView.image = UIImage(data: data)
                 }
             }
             task.resume()
         }
        
             return vendorCell
       }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let dict = arrAllVendor?[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "VendorFilterVC") as? VendorFilterVC
        vc?.vendorType = dict?.id
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (UIScreen.main.bounds.width - 20) / 3
       let hgt = (UIScreen.main.bounds.height) / 4
       return CGSize(width: size, height: hgt)
    }
}



extension AllVendorsController {
    func vendorData() {
        let dictparam = ["id":53] as [String:Any]
        
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.vendorDetail(with: dictparam, success: { (vendorData) in
            self.hideActivityIndicator(uiView: self.view)
            print(vendorData)
            self.arrAllVendor = vendorData.vendor_types
            self.vendorsCollView.reloadData()
        }){ (error) in
            self.hideActivityIndicator(uiView: self.view)
            
            // SupportMethod.showAlertMessage(messageStr: "Try Again")
        }
    }
}
