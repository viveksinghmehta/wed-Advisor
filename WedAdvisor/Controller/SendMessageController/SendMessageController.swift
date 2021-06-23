//
//  SendMessageController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 27/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class SendMessageController: UIViewController {
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtFunctionDate: UITextField!
    @IBOutlet weak var txtNoOfGuest: UITextField!
    @IBOutlet weak var txtNoOfRoom: UITextField!
     @IBOutlet weak var imgPreweddingFuncType: UIImageView!
    @IBOutlet weak var BtnPreweddingFuncType: UIButton!
     @IBOutlet weak var imgWeddingFuncType: UIImageView!
    @IBOutlet weak var BtnWeddingFuncType: UIButton!
     @IBOutlet weak var imgPreweddingTime: UIImageView!
    @IBOutlet weak var BtnPreweddingTime: UIButton!
     @IBOutlet weak var imgWeddingTime: UIImageView!
    @IBOutlet weak var BtnWeddingTime: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func funcTypeSelectBtnTapped(sender: UIButton){
          
       }
    @IBAction func funcTimeSelectBtnTapped(sender: UIButton){
            
         }
    
    @IBAction func sendMessageBtnTapped(sender: UIButton){
       
    }

}
