//
//  SeatingTablePopUpController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 22/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class SeatingTablePopUpController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var selectGuestView: UIView!
    @IBOutlet weak var txtTableName: UITextField!
    @IBOutlet weak var txtSeating: UITextField!
    @IBOutlet weak var txtSelectGuest: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.design()
        
        
    }
    
    func design(){
        
        selectGuestView.layer.masksToBounds = false
        selectGuestView.layer.borderColor = WedAdviserColor.textViewBorderColor().cgColor
        selectGuestView.layer.borderWidth = 1.0
        
        
        txtTableName.layer.masksToBounds = false
        txtTableName.layer.borderColor = WedAdviserColor.textViewBorderColor().cgColor
        txtTableName.layer.borderWidth = 1.0
        
        txtSeating.layer.masksToBounds = false
        txtSeating.layer.borderColor = WedAdviserColor.textViewBorderColor().cgColor
        txtSeating.layer.borderWidth = 1.0
    }
    
    @IBAction func removePopUpBtn(sender: UIButton){
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    @IBAction func createTableBtnTapped(sender: UIButton){
           self.view.removeFromSuperview()
           self.removeFromParent()
       }
    
    
    
}
