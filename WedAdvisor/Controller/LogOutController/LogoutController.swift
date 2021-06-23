//
//  LogoutController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 26/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class LogoutController: UIViewController {
    
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var btnNoLogout: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnNoLogout.layer.borderColor = WedAdviserColor.themeOrangeColor().cgColor
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnNotLogout(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func btnLogout(_ sender: Any) {
      //  let token = UserDefaults.standard.string(forKey: "BearerToken")
        UserDefaults.standard.removeObject(forKey: "BearerToken")
        let alert = UIAlertController(title: "", message: "Logout Successfully", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        // change to desired number of seconds (in this case 5 seconds)
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
        // your code with delay
            alert.dismiss(animated: true, completion: nil)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterController") as? RegisterController
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    
}
