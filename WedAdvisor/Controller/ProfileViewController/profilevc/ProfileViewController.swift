//
//  ProfileViewController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 27/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnMale: UIButton!
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var imgWhatsappUpdate: UIImageView!
    @IBOutlet weak var btnWhatsappUpdate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func genderBtnTapped(sender: UIButton){
          
      }
    

    
    @IBAction func setPasswordBtnTapped(sender: UIButton){
        
    }
    @IBAction func whatsappUpdateBtnTapped(sender: UIButton){
        
    }
    
    @IBAction func logoutBtnTapped(sender: UIButton){
        
    }


}
