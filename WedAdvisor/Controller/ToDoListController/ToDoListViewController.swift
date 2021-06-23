//
//  ToDoListViewController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 19/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController, doneTask{
    func donetask(value: Bool) {
        todoList()
        todoListing()
    }
    
    
    @IBOutlet weak var lblGuest: UILabel!
    @IBOutlet weak var toDoListTbl: UITableView!
    @IBOutlet weak var lblAccepted: UILabel!
    @IBOutlet weak var lblWaiting: UILabel!
    @IBOutlet weak var lblDeclined: UILabel!
    @IBOutlet weak var heightTable: NSLayoutConstraint!
    
    var arrList : [ToDoListDataModel]?
    var deleteId : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibs()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        todoList()
        todoListing()
    }
    
    // MARK:- Register cell
    func registerNibs(){
        let newTaskNib = UINib(nibName: "NewTaskCell" , bundle: nil)
        toDoListTbl.register(newTaskNib, forCellReuseIdentifier: "NewTaskCell")
        
        
    }
    @IBAction func backBtn(sender: UIButton){
           self.navigationController?.popViewController(animated: true)
       }
    
    @IBAction func btnNewTask(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ToDoListPopUpController") as? ToDoListPopUpController
        vc?.delegateDone = self
        vc?.checkFromAdd = true
        self.present(vc!, animated: true, completion: nil)

    }

    
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print(arrList?.count)
        return arrList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.toDoListTbl.dequeueReusableCell(withIdentifier: "NewTaskCell", for: indexPath)as? NewTaskCell
        let dict = arrList?[indexPath.row]
        cell?.lblTitle.text = dict?.task_title
        let newdate = dict?.task_date ?? ""
        let a = self.convertDateFormat(inputDate: newdate)
        cell?.lblDate.text = a

            cell?.ViewDeleteClosure = {
                var refreshAlert = UIAlertController(title: "", message: "Are You Sure You Want To Delete This Task", preferredStyle: UIAlertController.Style.alert)

                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                  print("Handle Ok logic here")
                    self.deleteId = dict?.id
                    self.deleteTask()
                    self.dismiss(animated: true, completion: nil)

                  }))

                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                  print("Handle Cancel Logic here")
                    self.dismiss(animated: true, completion: nil)
                  }))

                self.present(refreshAlert, animated: true, completion: nil)
                
            }
        cell?.ViewEditClosure = {
            let editToDo = EditTODOController()
            editToDo.view.backgroundColor = UIColor.clear
//            editToDo.definesPresentationContext = true
            editToDo.modalPresentationStyle = .overFullScreen
            self.present(editToDo, animated: false, completion: nil)
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ToDoListPopUpController") as? ToDoListPopUpController
//             vc?.delegateDone = self
//             vc?.checkFromAdd = false
//            var newdate = dict?.task_date ?? ""
//            vc?.titleTask = dict?.task_title
//            print(dict?.id)
//            vc?.taskId = dict?.id
//            let a =  self.convertDateFormatEdit(inputDate: newdate)
//            vc?.dateTask = a
////            if let dotRange = newdate.range(of: ".") {
////                newdate.removeSubrange(dotRange.lowerBound..<newdate.endIndex)
////                print(newdate)
////                let a =  self.convertDateFormatEdit(inputDate: newdate)
////                vc?.dateTask = a
////
////            }
//             self.present(vc!, animated: true, completion: nil)
  
        }
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func convertDateFormat(inputDate: String) -> String {
         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd"
         let oldDate = olDateFormatter.date(from: inputDate)
         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "dd MMM , yyyy"
         return convertDateFormatter.string(from: oldDate!)
    }
    
    func convertDateFormatEdit(inputDate: String) -> String {
         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd"
         let oldDate = olDateFormatter.date(from: inputDate)
         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "MM/dd/yyyy"
         return convertDateFormatter.string(from: oldDate!)
    }
    
    func connfigTableHeight(){
        if arrList?.count == 0{
            let numberOfLines = arrList?.count ?? 0
            heightTable.constant = CGFloat(150*numberOfLines)
            toDoListTbl.reloadData()
        }
        else{
            let numberOfLines = arrList?.count ?? 0/1+1
            heightTable.constant = CGFloat(150*numberOfLines)
            print(heightTable.constant)
            toDoListTbl.reloadData()
        }
    }
    
}
extension ToDoListViewController{
    
    
    func todoList() {
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.TodoList(success: { (todoData) in
            self.hideActivityIndicator(uiView: self.view)
            if let completed = todoData.completedtask{
                self.lblGuest.text = "\(completed)"
            }
            if let duetask = todoData.duetask{
                self.lblAccepted.text = "\(duetask)"
            }
            if let waiting = todoData.pendingtask{
                self.lblWaiting.text = "\(waiting)"
            }
            if let total = todoData.alltask{
                self.lblDeclined.text = "\(total)"
            }
        })
            
        { (error) in
            self.hideActivityIndicator(uiView: self.view)
        }
    }
    func todoListing()
       {
           self.showActivityIndicator(uiView: self.view)
           APIManager.sharedInstance.TodoListData(success: { (todoData) in
               self.hideActivityIndicator(uiView: self.view)
               if let dataList = todoData.todolist?.data{
                   self.arrList = dataList
               }
            self.connfigTableHeight()
               //self.toDoListTbl.reloadData()
           })
               
           { (error) in
               self.hideActivityIndicator(uiView: self.view)
           }
       }
    
    func deleteTask()
    {
        let dictparam = ["data": deleteId ?? 0] as [String:Any]
        
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.deleteTask(with: dictparam, success: { (todoadd) in
            self.hideActivityIndicator(uiView: self.view)
            print(todoadd)
            if todoadd.status == 200{
           let alert = UIAlertController(title: "", message: "Task Deleted Successfully", preferredStyle: .alert)
           self.present(alert, animated: true, completion: nil)
           // change to desired number of seconds (in this case 5 seconds)
           let when = DispatchTime.now() + 3
           DispatchQueue.main.asyncAfter(deadline: when){
           // your code with delay
               alert.dismiss(animated: true, completion: nil)
            self.todoListing()
            self.todoList()

                }
            }
        }){ (error) in
            self.hideActivityIndicator(uiView: self.view)
        }
    }
    
    
}
