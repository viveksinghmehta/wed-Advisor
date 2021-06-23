//
//  TabBarVC.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 14/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

enum ButtonType {
    case home,vendor,photo,wedding,blog
}

class TabBarVC: UIViewController {
    
    var selectedButton: ButtonType?
    var controller: UIViewController?
    var currentVC: UIViewController?
    static  let sharedInstance = TabBarVC()
    override func viewDidLoad() {
        super.viewDidLoad()
        statusbarcolor()
        if let safeSelectedButton = selectedButton{
            if safeSelectedButton == .home{
                let vc = storyboard?.instantiateViewController(withIdentifier: "NewHomeVC") as? NewHomeVC
                guard let safeVC = vc else{return}
                moveToTabVC(currentVC: self, nextVC: safeVC)
                //            imgHome.image = #imageLiteral(resourceName: "login_logo")
                //            imgCalender.image = #imageLiteral(resourceName: "CalenderTabUnselected")
                //            imgCategory.image = #imageLiteral(resourceName: "CategoryTabUnselected")
                //            imgSize.image = #imageLiteral(resourceName: "SizeTabUnselected")
                //            imgProfile.image = #imageLiteral(resourceName: "ProfileTabUnselected")
                
            }
            if safeSelectedButton == .vendor{
                let vc = storyboard?.instantiateViewController(withIdentifier: "AllVendorsController") as? AllVendorsController
                guard let safeVC = vc else{return}
                moveToTabVC(currentVC: self, nextVC: safeVC)
                //            imgHome.image = #imageLiteral(resourceName: "login_logo")
                //            imgCalender.image = #imageLiteral(resourceName: "CalenderTabSelected")
                //            imgCategory.image = #imageLiteral(resourceName: "CategoryTabUnselected")
                //            imgSize.image = #imageLiteral(resourceName: "SizeTabUnselected")
                //            imgProfile.image = #imageLiteral(resourceName: "ProfileTabUnselected")
                
            }
            if safeSelectedButton == .photo{
                let vc = storyboard?.instantiateViewController(withIdentifier: "GallaryController") as? GallaryController
                guard let safeVC = vc else{return}
                moveToTabVC(currentVC: self, nextVC: safeVC)
                //            imgHome.image = #imageLiteral(resourceName: "login_logo")
                //            imgCalender.image = #imageLiteral(resourceName: "CalenderTabUnselected")
                //            imgCategory.image = #imageLiteral(resourceName: "CategoryTabSeelected")
                //            imgSize.image = #imageLiteral(resourceName: "SizeTabUnselected")
                //            imgProfile.image = #imageLiteral(resourceName: "ProfileTabUnselected")
                
                
            }
            if safeSelectedButton == .wedding{
                let vc = storyboard?.instantiateViewController(withIdentifier: "NewHomeVC") as? NewHomeVC
                guard let safeVC = vc else{return}
                moveToTabVC(currentVC: self, nextVC: safeVC)
                //            imgHome.image = #imageLiteral(resourceName: "login_logo")
                //            imgCalender.image = #imageLiteral(resourceName: "CalenderTabUnselected")
                //            imgCategory.image = #imageLiteral(resourceName: "CategoryTabUnselected")
                //            imgSize.image = #imageLiteral(resourceName: "SizeTabSelected")
                //            imgProfile.image = #imageLiteral(resourceName: "ProfileTabUnselected")
                
            }
            if safeSelectedButton == .blog{
                let vc = storyboard?.instantiateViewController(withIdentifier: "BlogListController") as? BlogListController
                
                guard let safeVC = vc else{return}
                moveToTabVC(currentVC: self, nextVC: safeVC)
                //            imgHome.image = #imageLiteral(resourceName: "login_logo")
                //            imgCalender.image = #imageLiteral(resourceName: "CalenderTabUnselected")
                //            imgCategory.image = #imageLiteral(resourceName: "CategoryTabUnselected")
                //            imgSize.image = #imageLiteral(resourceName: "SizeTabUnselected")
                //            imgProfile.image = #imageLiteral(resourceName: "ProfileTabSelected")
                
            }
            
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewHomeVC") as? NewHomeVC
        guard let safeVC = vc else{return}
        moveToTabVC(currentVC: self, nextVC: safeVC)
        //             imgHome.image = #imageLiteral(resourceName: "login_logo")
        //             imgCalender.image = #imageLiteral(resourceName: "CalenderTabUnselected")
        //             imgCategory.image = #imageLiteral(resourceName: "CategoryTabUnselected")
        //             imgSize.image = #imageLiteral(resourceName: "SizeTabUnselected")
        //             imgProfile.image = #imageLiteral(resourceName: "ProfileTabUnselected")
        
        
    }
    
    // Status bar color
             func statusbarcolor(){
                 let statusBar =  UIView()
                        statusBar.frame = UIApplication.shared.statusBarFrame
                 statusBar.backgroundColor = WedAdviserColor.themeOrangeColor()
                        UIApplication.shared.keyWindow?.addSubview(statusBar)
             }
    
    //MARK:- Button Outlets
    @IBAction func btnHome(_ sender: Any) {
        selectedButton = .home
         let vc = storyboard?.instantiateViewController(withIdentifier: "NewHomeVC") as? NewHomeVC
         guard let safeVC = vc else{return}
        moveToTabVC(currentVC: self, nextVC: safeVC)
//         imgHome.image = #imageLiteral(resourceName: "login_logo")
//         imgCalender.image = #imageLiteral(resourceName: "CalenderTabSelected")
//         imgCategory.image = #imageLiteral(resourceName: "CategoryTabUnselected")
//         imgSize.image = #imageLiteral(resourceName: "SizeTabUnselected")
//         imgProfile.image = #imageLiteral(resourceName: "ProfileTabUnselected")
        
    }
    
    @IBAction func btnVendor(_ sender: Any) {
        selectedButton = .vendor
        let vc = storyboard?.instantiateViewController(withIdentifier: "AllVendorsController") as? AllVendorsController
        guard let safeVC = vc else{return}
       moveToTabVC(currentVC: self, nextVC: safeVC)
//        imgHome.image = #imageLiteral(resourceName: "login_logo")
//        imgCalender.image = #imageLiteral(resourceName: "CalenderTabUnselected")
//        imgCategory.image = #imageLiteral(resourceName: "CategoryTabSeelected")
//        imgSize.image = #imageLiteral(resourceName: "SizeTabUnselected")
       // imgProfile.image = #imageLiteral(resourceName: "ProfileTabUnselected")
    }
    
    @IBAction func btnPicture(_ sender: Any) {
        selectedButton = .photo
        let vc = storyboard?.instantiateViewController(withIdentifier: "GallaryController") as? GallaryController
        guard let safeVC = vc else{return}
        moveToTabVC(currentVC: self, nextVC: safeVC)
//        imgHome.image = #imageLiteral(resourceName: "login_logo")
//        imgCalender.image = #imageLiteral(resourceName: "CalenderTabUnselected")
//        imgCategory.image = #imageLiteral(resourceName: "CategoryTabUnselected")
//        imgSize.image = #imageLiteral(resourceName: "SizeTabUnselected")
//        imgProfile.image = #imageLiteral(resourceName: "ProfileTabUnselected")

        
        
    }
    @IBAction func btnWedding(_ sender: Any) {
        selectedButton = .wedding
               let vc = storyboard?.instantiateViewController(withIdentifier: "WeddingController") as? WeddingController
               guard let safeVC = vc else{return}
               moveToTabVC(currentVC: self, nextVC: safeVC)
//        imgHome.image = #imageLiteral(resourceName: "login_logo")
//        imgCalender.image = #imageLiteral(resourceName: "CalenderTabUnselected")
//        imgCategory.image = #imageLiteral(resourceName: "CategoryTabUnselected")
//        imgSize.image = #imageLiteral(resourceName: "SizeTabSelected")
//        imgProfile.image = #imageLiteral(resourceName: "ProfileTabUnselected")
    }
    @IBAction func btnBlog(_ sender: Any) {
        selectedButton = .blog
               let vc = storyboard?.instantiateViewController(withIdentifier: "BlogListController") as? BlogListController
               guard let safeVC = vc else{return}
               moveToTabVC(currentVC: self, nextVC: safeVC)
//        imgHome.image = #imageLiteral(resourceName: "login_logo")
//        imgCalender.image = #imageLiteral(resourceName: "CalenderTabUnselected")
//        imgCategory.image = #imageLiteral(resourceName: "CategoryTabUnselected")
//        imgSize.image = #imageLiteral(resourceName: "SizeTabUnselected")
//        imgProfile.image = #imageLiteral(resourceName: "ProfileTabSelected")
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
    
    //MARK:- setup device
    func device(){
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            print("iPhone 5 or 5S or 5C")
        controller?.view.frame = CGRect(x: 0, y: 0, width: view.frame.width , height:view.frame.height - 70)
        case 1334:
            print("iPhone 6/6S/7/8")
            controller?.view.frame = CGRect(x: 0, y: 0, width: view.frame.width , height:view.frame.height - 70)
            
        case 1920, 2208:
            
            print("iPhone 6+/6S+/7+/8+")
            controller?.view.frame = CGRect(x: 0, y: 0, width: view.frame.width , height:view.frame.height - 70)
            
        case 2436:
            print("iPhone X/XS/11 Pro")
            controller?.view.frame = CGRect(x: 0, y: 0, width: view.frame.width , height:view.frame.height - 70)
            
        case 2688:
            print("iPhone XS Max/11 Pro Max")
            controller?.view.frame = CGRect(x: 0, y: 0, width: view.frame.width , height:view.frame.height - 70)
        case 1792:
            print("iPhone XR/ 11 ")
            controller?.view.frame = CGRect(x: 0, y: 0, width: view.frame.width , height:view.frame.height - 70)
        default:
            controller?.view.frame = CGRect(x: 0, y: 0, width: view.frame.width , height:view.frame.height - 70)
        }
    }
    
    
}
