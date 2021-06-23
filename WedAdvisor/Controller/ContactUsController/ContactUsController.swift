//
//  ContactUsController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 14/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class ContactUsController: UIViewController {
    
     @IBOutlet weak var txtName: UITextField!
     @IBOutlet weak var txtMobile: UITextField!
     @IBOutlet weak var txtDate: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func callBtnTapped(sender: UIButton){
       
    }


}
