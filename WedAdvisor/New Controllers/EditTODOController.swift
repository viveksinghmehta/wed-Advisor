//
//  EditTODOController.swift
//  WedAdvisor
//
//  Created by Vivek Singh Mehta on 17/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class EditTODOController: UIViewController {
    
    enum textFieldType {
        case date
        case status
    }
    
    @IBOutlet weak var titleTF: SkyFloatingLabelTextField!
    @IBOutlet weak var dateTF: SkyFloatingLabelTextField!
    @IBOutlet weak var statusTF: SkyFloatingLabelTextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    
    
    let datePicker = UIDatePicker()
    let pickerView = UIPickerView()
    let toolBar = UIToolbar()
    var fieldType: textFieldType = .date
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTextFIields()
        roundCorners()
        doDatePicker()
    }
    
    fileprivate func roundCorners() {
        ContainerView.layer.cornerRadius = 15
        ContainerView.clipsToBounds = true
        submitButton.layer.cornerRadius = 6
        submitButton.clipsToBounds = true
    }
    
    fileprivate func initTextFIields() {
        titleTF.placeholder = "Title"
        dateTF.placeholder = "Date"
        statusTF.placeholder = "Status"
        titleTF.lineColor = .clear
        dateTF.lineColor = .clear
        statusTF.lineColor = .clear
        titleTF.textColor = .black
        dateTF.textColor = .lightGray
        statusTF.textColor = .lightGray
        dateTF.inputAccessoryView = toolBar
        dateTF.inputView = datePicker
        titleTF.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        dateTF.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        statusTF.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        titleTF.selectedLineColor = UIColor(named: "AppLightOrangeColor")!
        dateTF.selectedLineColor = UIColor(named: "AppLightOrangeColor")!
        statusTF.selectedLineColor = UIColor(named: "AppLightOrangeColor")!
        titleTF.selectedTitleColor = UIColor(named: "AppLightOrangeColor")!
        dateTF.selectedTitleColor = UIColor(named: "AppLightOrangeColor")!
        statusTF.selectedTitleColor = UIColor(named: "AppLightOrangeColor")!
    }
    
    fileprivate func doDatePicker() {
        // DatePicker
        datePicker.backgroundColor = UIColor.white
        datePicker.datePickerMode = UIDatePicker.Mode.date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        // ToolBar
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancel))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        self.view.addSubview(toolBar)
        self.toolBar.isHidden = false
     }
    
    
    @objc fileprivate func done() {
        if fieldType == .date {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, MMM d, yyyy"
            dateTF.text = formatter.string(from: datePicker.date)
            self.view.endEditing(true)
        } else {
            self.view.endEditing(true)
        }
    }
    
    
    @objc fileprivate func cancel() {
        self.view.endEditing(true)
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
    }
    
    
    @IBAction func closeAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
