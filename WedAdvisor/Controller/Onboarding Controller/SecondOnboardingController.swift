//
//  SecondOnboardingController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 14/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class SecondOnboardingController: UIViewController {
    //MARK:- OUtlets
    @IBOutlet weak var secondSwipeView: UIView!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var secondTitleLbl: UILabel!
        @IBOutlet weak var secondDescriptionLbl: UILabel!
       @IBOutlet weak var imgBackground: UIImageView!
       var coverView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
         let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
         swipeRight.direction = UISwipeGestureRecognizer.Direction.right
         self.secondSwipeView.addGestureRecognizer(swipeRight)
         let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
         swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
         self.secondSwipeView.addGestureRecognizer(swipeLeft)
         
        let attributedString = NSMutableAttributedString(string: "Lorem Ipsum is simply dummy text of the printing and typesetting")
         let paragraphStyle = NSMutableParagraphStyle()
         paragraphStyle.lineSpacing = 10
         attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        // wishlistInfoLbl.attributedText = attributedString
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         navigationController?.setNavigationBarHidden(true, animated: animated)
     }
     
     @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
         if let swipeGesture = gesture as? UISwipeGestureRecognizer {
             switch swipeGesture.direction {
             case UISwipeGestureRecognizer.Direction.right:
                 let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                 DispatchQueue.main.async { //make sure all UI updates are on the main thread.
                     let resultViewController = storyBoard.instantiateViewController(withIdentifier: "FirstOnboardingController") as! FirstOnboardingController
                     resultViewController.view.layer.add(CATransition().segueFromLeft(), forKey: nil)
                     self.navigationController?.popViewController(animated: true)
                 }
             case UISwipeGestureRecognizer.Direction.left:
                 let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                 let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ThirdOnboardingController") as! ThirdOnboardingController
                 self.navigationController?.pushViewController(resultViewController, animated: true)
             default:
                 break
             }
         }
     }
    

  //MARK:- Button Outlets
    
    @IBAction func btnSkip(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ThirdOnboardingController") as? ThirdOnboardingController
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    @IBAction func btnNextTapped(_ sender: Any) {
              let vc = storyboard?.instantiateViewController(withIdentifier: "ThirdOnboardingController") as? ThirdOnboardingController
              self.navigationController?.pushViewController(vc!, animated: true)
          }
}
