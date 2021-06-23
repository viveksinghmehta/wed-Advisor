//
//  MasterVendorDetail.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 15/04/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
//import WMSegmentControl
class MasterVendorDetail: UIViewController {
   var container: ContainerViewController!

    @IBOutlet weak var viewSEgment: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
   

    @IBAction func AboutBtnTapped(sender: UIButton) {
        container!.segueIdentifierReceivedFromParent("first")

    }
    
    
    @IBAction func GallaryBtnTapped(sender: UIButton) {
        container!.segueIdentifierReceivedFromParent("second")

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container"{
            container = segue.destination as! ContainerViewController
            //For adding animation to the transition of containerviews you can use container's object property
            // animationDurationWithOptions and pass in the time duration and transition animation option as a tuple
            // Animations that can be used
            // .transitionFlipFromLeft, .transitionFlipFromRight, .transitionCurlUp
            // .transitionCurlDown, .transitionCrossDissolve, .transitionFlipFromTop
            container.animationDurationWithOptions = (0.5, .transitionCrossDissolve)
        }
    }
    
}
