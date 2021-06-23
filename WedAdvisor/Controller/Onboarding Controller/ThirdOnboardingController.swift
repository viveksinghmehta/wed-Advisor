//
//  ThirdOnboardingController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 14/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class ThirdOnboardingController: UIViewController {
    
    //MARK:- OUtlets
    @IBOutlet weak var thirdSwipeView: UIView!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var thirdTitleLbl: UILabel!
    @IBOutlet weak var thirdDescriptionLbl: UILabel!
       @IBOutlet weak var imgBackground: UIImageView!
       var coverView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
                 let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
         swipeRight.direction = UISwipeGestureRecognizer.Direction.right
         self.thirdSwipeView.addGestureRecognizer(swipeRight)
//         let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
//         swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
//         self.secondSwipeView.addGestureRecognizer(swipeLeft)
         
       // let attributedString = NSMutableAttributedString(string: "Lorem Ipsum is simply dummy text of the printing and typesetting")
         let paragraphStyle = NSMutableParagraphStyle()
         paragraphStyle.lineSpacing = 10
        // attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

    }
    
     @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
         if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                 DispatchQueue.main.async { //make sure all UI updates are on the main thread.
                     let resultViewController = storyBoard.instantiateViewController(withIdentifier: "SecondOnboardingController") as! SecondOnboardingController
                     resultViewController.view.layer.add(CATransition().segueFromLeft(), forKey: nil)
                     self.navigationController?.popViewController(animated: true)
            }
         }
     }
       
       override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(animated)
              navigationController?.setNavigationBarHidden(true, animated: animated)
          }
    
    //MARK:- Button Outlets
    
    @IBAction func registerOrLoginBtnTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterController") as? RegisterController
        self.navigationController?.pushViewController(vc!, animated: true)

    }
  

}
