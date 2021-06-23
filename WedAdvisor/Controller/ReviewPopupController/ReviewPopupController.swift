//
//  ReviewPopupController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 20/02/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class ReviewPopupController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitBtnTapped(_ sender: UIButton) {
           self.view.removeFromSuperview()
           self.removeFromParent()
       }
    

}
