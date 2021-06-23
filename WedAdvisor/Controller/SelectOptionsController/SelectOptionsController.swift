//
//  SelectOptionsController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 18/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit


class SelectOptionsController: UIViewController {
    
    @IBOutlet weak var selectOptionsCollection: UICollectionView!
    var controller: UIViewController?
    var currentVC: UIViewController?
    static  let sharedInstance = TabBarVC()
    
    var arrTabOptions = ["Profile", "Phone", "Password Change", "Email Notifications", "Delete Account"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.selectOptionsCollection.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
    }
    
    // MARK:- Register cell
    func registerNibs(){
        selectOptionsCollection.register(UINib.init(nibName: "SelectOptionsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SelectOptionsCollectionCell")
        
    }
    
    public func moveToTabVC(currentVC: UIViewController, nextVC: UIViewController)
    {
        if let safeCurrentVC = self.currentVC{
            if safeCurrentVC == nextVC{
                return
            }else{
                
                let childrens = self.children
                if childrens.count > 0{
                    controller?.willMove(toParent: nil)
                    controller?.view.removeFromSuperview()
                    controller?.removeFromParent()
                    controller  = nextVC
                    device()
                    
                    //controller?.view.frame = CGRect(x: 0, y: 0, width: view.frame.width , height:view.frame.height - 70)
                    controller?.willMove(toParent: currentVC)
                    guard let safeController = controller else{return}
                    currentVC.view.addSubview(safeController.view)
                    currentVC.addChild(safeController)
                    safeController.didMove(toParent: currentVC)
                    
                }else{
                    controller  = nextVC
                    device()
                    // controller?.view.frame = CGRect(x: 0, y: 0, width: view.frame.width , height:view.frame.height - 70)
                    controller?.willMove(toParent: currentVC)
                    guard let safeController = controller else{return}
                    currentVC.view.addSubview(safeController.view)
                    currentVC.addChild(safeController)
                    safeController.didMove(toParent: currentVC)
                    
                }
            }
        }else{
            
            let childrens = self.children
            if childrens.count > 0{
                controller?.willMove(toParent: nil)
                controller?.view.removeFromSuperview()
                controller?.removeFromParent()
                controller  = nextVC
                device()
                //controller?.view.frame = CGRect(x: 0, y: 0, width: view.frame.width , height:view.frame.height - 70)
                controller?.willMove(toParent: currentVC)
                guard let safeController = controller else{return}
                currentVC.view.addSubview(safeController.view)
                currentVC.addChild(safeController)
                safeController.didMove(toParent: currentVC)
                
            }else{
                controller  = nextVC
                device()
                //  controller?.view.frame = CGRect(x: 0, y: 0, width: view.frame.width , height:view.frame.height - 70)
                controller?.willMove(toParent: self)
                guard let safeController = controller else{return}
                currentVC.view.addSubview(safeController.view)
                currentVC.addChild(safeController)
                safeController.didMove(toParent: currentVC)
            }
        }
        self.currentVC = nextVC
    }
    
    @IBAction func backBtn(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- setup device
    func device(){
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            print("iPhone 5 or 5S or 5C")
            
        case 1334:
            print("iPhone 6/6S/7/8")
            controller?.view.frame = CGRect(x: 0, y: 100, width: view.frame.width , height:view.frame.height)
            
        case 1920, 2208:
            
            print("iPhone 6+/6S+/7+/8+")
            controller?.view.frame = CGRect(x: 0, y: 160, width: view.frame.width , height:view.frame.height)
            
        case 2436:
            print("iPhone X/XS/11 Pro")
            controller?.view.frame = CGRect(x: 0, y: 120, width: view.frame.width , height:view.frame.height)
            
        case 2688:
            print("iPhone XS Max/11 Pro Max")
            controller?.view.frame = CGRect(x: 0, y: 170, width: view.frame.width , height:view.frame.height)
        case 1792:
            print("iPhone XR/ 11 ")
            controller?.view.frame = CGRect(x: 0, y: 180, width: view.frame.width , height:view.frame.height)
        default:
            controller?.view.frame = CGRect(x: 0, y: 120, width: view.frame.width , height:view.frame.height)
        }
    }
    
    
    
}

extension SelectOptionsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  arrTabOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = selectOptionsCollection.dequeueReusableCell(withReuseIdentifier: "SelectOptionsCollectionCell", for: indexPath as IndexPath) as! SelectOptionsCollectionCell
        cell.selectOptionsLbl.text = arrTabOptions[indexPath.row]
        if indexPath.row == 0
        {
            selectOptionsCollection.selectItem(at: indexPath, animated: true, scrollPosition: .right) //Add this line
            cell.isSelected = true
            let vc = storyboard?.instantiateViewController(withIdentifier: "MyProfileController") as? MyProfileController
            moveToTabVC(currentVC: self, nextVC: vc!)
        }
        else{
            cell.isSelected = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = selectOptionsCollection.dequeueReusableCell(withReuseIdentifier: "SelectOptionsCollectionCell", for: indexPath as IndexPath) as! SelectOptionsCollectionCell
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let size: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: size.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let vc = storyboard?.instantiateViewController(withIdentifier: "MyProfileController") as? MyProfileController
            
            guard let safeVC = vc else{return}
            moveToTabVC(currentVC: self, nextVC: safeVC)
        }
            
        else if indexPath.row == 1{
            let vc = storyboard?.instantiateViewController(withIdentifier: "PhoneVC") as? PhoneVC
            
            guard let safeVC = vc else{return}
            moveToTabVC(currentVC: self, nextVC: safeVC)
        }
        else if indexPath.row == 2{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ChangePasswordController") as? ChangePasswordController
            
            guard let safeVC = vc else{return}
            moveToTabVC(currentVC: self, nextVC: safeVC)
        }
        else if indexPath.row == 3{
            let vc = storyboard?.instantiateViewController(withIdentifier: "EmailNotificationController") as? EmailNotificationController
            
            guard let safeVC = vc else{return}
            moveToTabVC(currentVC: self, nextVC: safeVC)
        }
        else if indexPath.row == 4{
            let vc = storyboard?.instantiateViewController(withIdentifier: "DeleteAccountController") as? DeleteAccountController
            
            guard let safeVC = vc else{return}
            moveToTabVC(currentVC: self, nextVC: safeVC)
        }
    }
    
}
