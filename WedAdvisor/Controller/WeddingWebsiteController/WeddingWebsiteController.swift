//
//  WeddingWebsiteController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 22/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class WeddingWebsiteController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }


}
