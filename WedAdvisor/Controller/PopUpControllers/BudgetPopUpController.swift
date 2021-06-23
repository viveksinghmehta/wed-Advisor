//
//  BudgetPopUpController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 22/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class BudgetPopUpController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var notesView: UIView!
    @IBOutlet weak var txtNotes : UITextView!
    @IBOutlet weak var BtnRemovePopUp : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCategory.layer.masksToBounds = false
        txtCategory.layer.borderColor = WedAdviserColor.textViewBorderColor().cgColor
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func removePopUpTapped(sender: UIButton){
        
        self.view.removeFromSuperview()
        self.removeFromParent()
        
    }
    @IBAction func addItemBtnTapped(_ sender: UIButton) {
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    
    
}
