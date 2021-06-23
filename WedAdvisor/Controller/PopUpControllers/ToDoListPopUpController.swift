//
//  ToDoListPopUpController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 20/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import YYCalendar
protocol doneTask {
    func donetask(value : Bool)
}
class ToDoListPopUpController: UIViewController {
    
    @IBOutlet weak var textTaskTitle: UITextField!
    @IBOutlet weak var textDate: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
     var titleTask : String?
     var dateTask : String?
     var delegateDone : doneTask?
      var checkFromAdd : Bool?
      var taskId : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        btnSubmit.layer.cornerRadius = 10
        btnRemove.layer.cornerRadius = btnRemove.frame.size.height / 2
        textTaskTitle.setLeftPaddingPoints(15)
        textDate.setLeftPaddingPoints(15)
        if checkFromAdd == false{
            textDate.text = titleTask
            textTaskTitle.text = dateTask
        }
//        let check = UserDefaults.standard.bool(forKey: "editCheck")
//        if check == false{
//        textDate.text =  UserDefaults.standard.string(forKey: "edittitle")
//        textTaskTitle.text =  UserDefaults.standard.string(forKey: "editDate")
//
//        }
        

    }
    
    func design(){
        self.textTaskTitle.layer.borderColor = WedAdviserColor.textFieldBorderColor().cgColor
        self.textDate.layer.borderColor = WedAdviserColor.textFieldBorderColor().cgColor
    }
    
    @IBAction func removePopUpBtn(sender: UIButton){
    //delegateTask?.addTask(title: "", date: "")
        self.dismiss(animated: true, completion: nil)
//           self.view.removeFromSuperview()
//           self.removeFromParent()
       }
    
    @IBAction func btnSubmit(_ sender: Any) {
        if checkFromAdd == false{
            if validationEmail(){
                EditTask()
            }
        }
        else{
            if validationEmail(){
                addTask()
            }
        }
    }
    
    
    //MARK:- VALIDATION Email
     func validationEmail() -> Bool{
        if (textTaskTitle.text == ""){
             alertShow(msg: "Please enter Date")
             return false
         }

            else if (textDate.text == ""){
                alertShow(msg: "Please enter Title")
                return false
            }

         return true
     }
    
    @IBAction func btnDate(_ sender: UIButton) {
        //***************https://github.com/DevYeom/YYCalendar *****************
        let dateType = HelpingMethods.sharedInstance.getCurrentDateTime()
        let currentDate = dateType.date
        let calendar = YYCalendar(limitedCalendarLangType: .ENG,date: currentDate,minDate: currentDate,maxDate: "01/01/2050",format: "dd/MM/yyyy"){
            [weak self] date in
            print(date)
            self?.textTaskTitle.text = self?.convertDateFormatEdit(inputDate: date)
        }
        calendar.show()
    }
      func alertShow(msg : String){
          // the alert view
    self.present(UIAlertController.alertWithTitle(title: "", message: msg , buttonTitle: "OK"), animated: true, completion: nil)
      }
    
    func convertDateFormatEdit(inputDate: String) -> String {
         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "dd/MM/yyyy"
         let oldDate = olDateFormatter.date(from: inputDate)
         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "MM/dd/yyyy"
         return convertDateFormatter.string(from: oldDate!)
    }
    
    
}
extension ToDoListPopUpController{
    func addTask()
    {
        let dictparam = ["tasktitle":textDate.text ?? "",
                         "taskdate":textTaskTitle.text ?? ""
            ] as [String:Any]
        
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.addTaskTodo(with: dictparam, success: { (todoadd) in
            self.hideActivityIndicator(uiView: self.view)
            print(todoadd)
            if todoadd.status == 200{
                
           let alert = UIAlertController(title: "", message: "Task Added Successfully", preferredStyle: .alert)
           self.present(alert, animated: true, completion: nil)
           // change to desired number of seconds (in this case 5 seconds)
           let when = DispatchTime.now() + 3
           DispatchQueue.main.asyncAfter(deadline: when){
           // your code with delay
               alert.dismiss(animated: true, completion: nil)
            self.delegateDone?.donetask(value: true)
            self.dismiss(animated: true, completion: nil)

//              self.view.removeFromSuperview()
//               self.removeFromParent()
           }

            }
            else if todoadd.status == 500{
                self.hideActivityIndicator(uiView: self.view)
                let alert = UIAlertController(title: "", message: "Internal Server Error", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                // change to desired number of seconds (in this case 5 seconds)
                let when = DispatchTime.now() + 3
                DispatchQueue.main.asyncAfter(deadline: when){
                // your code with delay
                    alert.dismiss(animated: true, completion: nil)
                 self.delegateDone?.donetask(value: true)
                 self.dismiss(animated: true, completion: nil)
            }
            }
        }){ (error) in
            self.hideActivityIndicator(uiView: self.view)
        }
    }
    
    
    func EditTask()
       {
           let dictparam = ["title":textDate.text ?? "",
                            "date":textTaskTitle.text ?? "",
                            "tasktid" : taskId ?? 0,
                            "status" : 2
               ] as [String:Any]
           
           self.showActivityIndicator(uiView: self.view)
           APIManager.sharedInstance.editTaskTodo(with: dictparam, success: { (todoadd) in
               self.hideActivityIndicator(uiView: self.view)
               print(todoadd)
               if todoadd.status == 200{
                   
              let alert = UIAlertController(title: "", message: "Task Edited Successfully", preferredStyle: .alert)
              self.present(alert, animated: true, completion: nil)
              // change to desired number of seconds (in this case 5 seconds)
              let when = DispatchTime.now() + 3
              DispatchQueue.main.asyncAfter(deadline: when){
              // your code with delay
                  alert.dismiss(animated: true, completion: nil)
               self.delegateDone?.donetask(value: true)
                self.dismiss(animated: true, completion: nil)
              }

               }
           }){ (error) in
               self.hideActivityIndicator(uiView: self.view)
           }
       }
}
