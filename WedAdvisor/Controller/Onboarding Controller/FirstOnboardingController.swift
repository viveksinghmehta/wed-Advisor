//
//  FirstOnboardingController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 13/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class FirstOnboardingController: UIViewController {
  //MARK:- OUtlets
    @IBOutlet weak var firstSwipeView: UIView!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var imgBackground: UIImageView!
     @IBOutlet weak var titleLbl: UILabel!
     @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var viewTwo: UIImageView!
    
    @IBOutlet weak var viewOne: UIImageView!
    var coverView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token = UserDefaults.standard.string(forKey: "BearerToken")
        if token != "" && token != nil{
            let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.firstSwipeView.addGestureRecognizer(swipeLeft)
        let attributedString = NSMutableAttributedString(string: "Lorem Ipsum is simply dummy text of the printing and typesetting")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10 // Whatever line spacing you want in points
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
       // eventInfoLbl.attributedText = attributedString
     //   viewTwo.isHidden = true
       
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
           if let swipeGesture = gesture as? UISwipeGestureRecognizer {
               let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            viewOne.isHidden = true
//            viewTwo.isHidden = false
               let resultViewController = storyBoard.instantiateViewController(withIdentifier: "SecondOnboardingController") as! SecondOnboardingController
               self.navigationController?.pushViewController(resultViewController, animated: true)
           }
       }
       
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.setNavigationBarHidden(true, animated: animated)
       }
    
    //MARK:- Button Outlets
    
    @IBAction func btnSkip(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SecondOnboardingController") as? SecondOnboardingController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnNextTapped(_ sender: Any) {
           let vc = storyboard?.instantiateViewController(withIdentifier: "SecondOnboardingController") as? SecondOnboardingController
           self.navigationController?.pushViewController(vc!, animated: true)
       }
}
