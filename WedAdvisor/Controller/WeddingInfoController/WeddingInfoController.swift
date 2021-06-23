//
//  WeddingInfoController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 20/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class WeddingInfoController: UIViewController {
    
     @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var textWeddingDate: UITextField!
    @IBOutlet weak var textAddress: UITextField!
     @IBOutlet weak var textBrideFirstName: UITextField!
     @IBOutlet weak var textBrideLastName: UITextField!
     @IBOutlet weak var textGroomFirstName: UITextField!
     @IBOutlet weak var textGroomLastName: UITextField!

    @IBOutlet weak var btnSave: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.design()

        btnSave.layer.cornerRadius = 6

        // Do any additional setup after loading the view.
    }
    
    func design () {
        self.countryView.layer.borderColor = WedAdviserColor.textFieldBorderColor().cgColor
               self.cityView.layer.borderColor = WedAdviserColor.textFieldBorderColor().cgColor
               self.stateView.layer.borderColor = WedAdviserColor.textFieldBorderColor().cgColor
               self.textWeddingDate.layer.borderColor = WedAdviserColor.textFieldBorderColor().cgColor
               self.textAddress.layer.borderColor = WedAdviserColor.textFieldBorderColor().cgColor
               self.textBrideFirstName.layer.borderColor = WedAdviserColor.textFieldBorderColor().cgColor
               self.textBrideLastName.layer.borderColor = WedAdviserColor.textFieldBorderColor().cgColor
               self.textGroomFirstName.layer.borderColor = WedAdviserColor.textFieldBorderColor().cgColor
               self.textGroomLastName.layer.borderColor = WedAdviserColor.textFieldBorderColor().cgColor
    }
    


}
