//
//  BudgetController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 21/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class BudgetController: UIViewController {
    
    @IBOutlet weak var budgetTbl: UITableView!
    @IBOutlet weak var btnBudget: UIButton!
    @IBOutlet weak var btnBudgetDetail: UIButton!
    @IBOutlet weak var btnAddBudgetCategory: UIButton!
     @IBOutlet weak var budgetView: UIView!
     @IBOutlet weak var budgetDetailsView: UIView!
    
    var checkForBudget: Int?
   // var checkForBudgetDtl: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
   
        budgetView.layer.backgroundColor = WedAdviserColor.buttonselectBackgroundColor().cgColor
        btnBudget.setTitleColor(WedAdviserColor.buttonTextSelectionColor(), for: .normal)
        registerNibs()
  checkForBudget = 0

    }
    
    // MARK:- Register cell
       func registerNibs(){
          let budgetNib = UINib(nibName: "BudgetCell" , bundle: nil)
           budgetTbl.register(budgetNib, forCellReuseIdentifier: "BudgetCell")
        let budgetDtlNib = UINib(nibName: "BudgetDetailCell" , bundle: nil)
        budgetTbl.register(budgetDtlNib, forCellReuseIdentifier: "BudgetDetailCell")
        

       }
    
    @IBAction func backBtn(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func addBudgetCategoryTapped(_ sender: UIButton) {
        
        let nVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BudgetPopUpController") as! BudgetPopUpController
                    self.view.addSubview(nVC.view)
                    nVC.view.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
                    addChild(nVC)
               
                    
                    didMove(toParent: self)
       }
    
    @IBAction func budgetButtonTapped(_ sender: UIButton) {
        checkForBudget = sender.tag
        budgetView.layer.backgroundColor = WedAdviserColor.buttonselectBackgroundColor().cgColor
          btnBudget.setTitleColor(WedAdviserColor.buttonTextSelectionColor(), for: .normal)
          btnBudgetDetail.setTitleColor(WedAdviserColor.buttonselectBackgroundColor(), for: .normal)
        budgetDetailsView.layer.backgroundColor = WedAdviserColor.buttonUnselectBackgroundColor().cgColor
        budgetTbl.reloadData()
        
    }
    
  
    @IBAction func budgetDetailTapped(_ sender: UIButton) {
        checkForBudget = sender.tag
         budgetDetailsView.layer.backgroundColor = WedAdviserColor.buttonselectBackgroundColor().cgColor
        budgetView.layer.backgroundColor = WedAdviserColor.buttonUnselectBackgroundColor().cgColor
        btnBudgetDetail.setTitleColor(WedAdviserColor.buttonTextSelectionColor(), for: .normal)
        btnBudget.setTitleColor(WedAdviserColor.buttonselectBackgroundColor(), for: .normal)
         budgetTbl.reloadData()
        
    }
    

}


extension BudgetController: UITableViewDelegate, UITableViewDataSource{
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print(checkForBudget)
    
    var cell: UITableViewCell?
  
    if checkForBudget == 0 {
       let budgetCell = budgetTbl.dequeueReusableCell(withIdentifier: "BudgetCell", for: indexPath)as? BudgetCell
        
          cell = budgetCell
       // return cell ?? UITableViewCell()
    } else if checkForBudget == 1 {
             let dtlCell = budgetTbl.dequeueReusableCell(withIdentifier: "BudgetDetailCell", for: indexPath)as? BudgetDetailCell
             
               cell = dtlCell
    }

     return cell!
   
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if checkForBudget == 0 {
         return 250
    }else if checkForBudget == 1 {
        return 850
    }
    return 0
  
}

}
