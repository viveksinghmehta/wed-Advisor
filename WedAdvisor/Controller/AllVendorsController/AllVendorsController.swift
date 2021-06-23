//
//  AllVendorsController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 13/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class AllVendorsController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
     @IBOutlet weak var vendorsCollView:UICollectionView!
     @IBOutlet weak var collViewHeight:NSLayoutConstraint!
    var arrAllVendor : [HomeVendorType]?
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var screenSize: CGRect!

    override func viewDidLoad() {
        super.viewDidLoad()
        self
        .categoryCollDimension()
        registerNibs()
            let statusBar1 =  UIView()
                       statusBar1.frame = UIApplication.shared.statusBarFrame
        statusBar1.backgroundColor = WedAdviserColor.themeOrangeColor()
                       UIApplication.shared.keyWindow?.addSubview(statusBar1)
                      self.setNeedsStatusBarAppearanceUpdate()
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
    
    @IBAction func backBtn(sender: UIButton){
          self.navigationController?.popViewController(animated: true)
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
       switch UIScreen.main.nativeBounds.height {
       case 1136:
        print("iPhone 5 or 5S or 5C")
        
       case 1334:
        print("iPhone 6/6S/7/8")
        let size = (screenWidth-20) / 3
        let hgt = (screenHeight) / 4
        return CGSize(width: size, height: hgt)
       case 1920, 2208:
        print("iPhone 6+/6S+/7+/8+")
      let size = (vendorsCollView.frame.width) / 3.2
        let hgt = (screenHeight) / 4.3
        return CGSize(width: size, height: hgt)
        
       case 2436:
        print("iPhone X/XS/11 Pro")
        let size = (vendorsCollView.frame.width) / 3.2
        let hgt = (screenHeight) / 4.8
        return CGSize(width: size, height: hgt)
       case 2688:
        print("iPhone XS Max/11 Pro Max")
        let size = (vendorsCollView.frame.width) / 3.2
        let hgt = (screenHeight) / 5.4
        return CGSize(width: size, height: hgt)
       case 1792:
        print("iPhone XR/ 11 ")
       let size = (screenWidth-20) / 3
        let hgt = (screenHeight) / 5.4
       return CGSize(width: size, height: hgt)
       case 1170:
        print("iphone12")
        let size = (screenWidth-20) / 3.3
        let hgt = (screenHeight) / 5.4
        return CGSize(width: size, height: hgt)
       default:
        let size = (screenWidth-20) / 3
        let hgt = (screenHeight) / 4
        return CGSize(width: size, height: hgt)
        }
       let size = (screenWidth-20) / 3
       let hgt = (screenHeight) / 4
       return CGSize(width: size, height: hgt)
    }
}



extension AllVendorsController{
    func vendorData()
    {
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
