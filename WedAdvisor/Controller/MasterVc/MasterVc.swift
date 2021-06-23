//
//  MasterVc.swift
//  WedAdvisor
//
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class MasterVc: UIViewController {
    @IBOutlet weak var containersView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

  override func viewWillAppear(_ animated: Bool) {
  super.viewWillAppear(animated)
  navigationController?.setNavigationBarHidden(true, animated: animated)
  }

}
