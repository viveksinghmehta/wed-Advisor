//
//  ActivityOptionsController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 21/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class ActivityOptionsController: UIViewController {

    @IBOutlet weak var selectOptionsCol: UICollectionView!
               var controller: UIViewController?
               var currentVC: UIViewController?
        static  let sharedInstance = TabBarVC()

        var arrTabOptions = ["Venue", "Photographer", "Videographer", "Dress", "Florist"]

        override func viewDidLoad() {
            super.viewDidLoad()
            registerNibs()
            statusbarcolor()

            // Do any additional setup after loading the view.
        }
        
          // MARK:- Register cell
             func registerNibs(){
                 selectOptionsCol.register(UINib.init(nibName: "SelectOptionsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SelectOptionsCollectionCell")

             }
    
    // Status bar color
       func statusbarcolor(){
           let statusBar =  UIView()
                  statusBar.frame = UIApplication.shared.statusBarFrame
           statusBar.backgroundColor = WedAdviserColor.themeOrangeColor()
                  UIApplication.shared.keyWindow?.addSubview(statusBar)
       }
    
    @IBAction func backBtn(sender: UIButton){
             self.navigationController?.popViewController(animated: true)
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
                          // device()
                           
                           //controller?.view.frame = CGRect(x: 0, y: 0, width: view.frame.width , height:view.frame.height - 70)
                           controller?.willMove(toParent: currentVC)
                           guard let safeController = controller else{return}
                           currentVC.view.addSubview(safeController.view)
                           currentVC.addChild(safeController)
                           safeController.didMove(toParent: currentVC)
                           
                       }else{
                           controller  = nextVC
                         //   device()
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
                     //  device()
                       //controller?.view.frame = CGRect(x: 0, y: 0, width: view.frame.width , height:view.frame.height - 70)
                       controller?.willMove(toParent: currentVC)
                       guard let safeController = controller else{return}
                       currentVC.view.addSubview(safeController.view)
                       currentVC.addChild(safeController)
                       safeController.didMove(toParent: currentVC)
                       
                   }else{
                       controller  = nextVC
                     //  device()
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
                 
             case 1334:
                 print("iPhone 6/6S/7/8/ SE")
                 controller?.view.frame = CGRect(x: 0, y: 110, width: view.frame.width , height:view.frame.height)

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

    extension ActivityOptionsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  arrTabOptions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = selectOptionsCol.dequeueReusableCell(withReuseIdentifier: "SelectOptionsCollectionCell", for: indexPath as IndexPath) as! SelectOptionsCollectionCell
         cell.selectOptionsLbl.text = arrTabOptions[indexPath.row]
        if indexPath.row == 0
        {
            selectOptionsCol.selectItem(at: indexPath, animated: true, scrollPosition: .right) //Add this line
            cell.isSelected = true
            let vc = storyboard?.instantiateViewController(withIdentifier: "MyWishListController") as? MyWishListController
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
    //        guard let cell: SelectOptionsCollectionCell = Bundle.main.loadNibNamed(SelectOptionsCollectionCell.nibName,
    //                                                                             owner: self,
    //                                                                             options: nil)?.first as? SelectOptionsCollectionCell else {
                      // return CGSize.zero
    //        }
           // cell.configureCell(name: names[indexPath.row])
            let cell = selectOptionsCol.dequeueReusableCell(withReuseIdentifier: "SelectOptionsCollectionCell", for: indexPath as IndexPath) as! SelectOptionsCollectionCell
           
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            let size: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

            
            return CGSize(width: size.width, height: 40)
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if indexPath.row == 0{
                let vc = storyboard?.instantiateViewController(withIdentifier: "MyWishListController") as? MyWishListController

                guard let safeVC = vc else{return}
                moveToTabVC(currentVC: self, nextVC: safeVC)
            }
                
                else if indexPath.row == 1{
                          let vc = storyboard?.instantiateViewController(withIdentifier: "MyWishListController") as? MyWishListController

                          guard let safeVC = vc else{return}
                          moveToTabVC(currentVC: self, nextVC: safeVC)
                      }
            else if indexPath.row == 2{
                let vc = storyboard?.instantiateViewController(withIdentifier: "MyWishListController") as? MyWishListController

                guard let safeVC = vc else{return}
                moveToTabVC(currentVC: self, nextVC: safeVC)
            }
                else if indexPath.row == 3{
                          let vc = storyboard?.instantiateViewController(withIdentifier: "MyWishListController") as? MyWishListController

                          guard let safeVC = vc else{return}
                          moveToTabVC(currentVC: self, nextVC: safeVC)
                      }
            else if indexPath.row == 4{
                       let vc = storyboard?.instantiateViewController(withIdentifier: "MyWishListController") as? MyWishListController

                       guard let safeVC = vc else{return}
                       moveToTabVC(currentVC: self, nextVC: safeVC)
                   }
        }
       
    }
