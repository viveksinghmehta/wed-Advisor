//
//  SeatingTableController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 22/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class SeatingTableController: UIViewController {
    
    @IBOutlet weak var seatingTbl: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()

    }
    
    // MARK:- Register cell
    func registerNibs(){
       let seatingNib = UINib(nibName: "SeatingTableCell" , bundle: nil)
        seatingTbl.register(seatingNib, forCellReuseIdentifier: "SeatingTableCell")
     
    }
    
    @IBAction func backBtn(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func addNewTableBtnTapped(sender: UIButton){
           
        let nVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeatingTablePopUpController") as! SeatingTablePopUpController
              self.view.addSubview(nVC.view)
              nVC.view.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
              addChild(nVC)
         
              
              didMove(toParent: self)
        
       }
    

}


extension SeatingTableController: UITableViewDelegate, UITableViewDataSource{
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
       let cell = seatingTbl.dequeueReusableCell(withIdentifier: "SeatingTableCell", for: indexPath)as? SeatingTableCell
        
     
     return cell!
   
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   return 250
    }
  

}
