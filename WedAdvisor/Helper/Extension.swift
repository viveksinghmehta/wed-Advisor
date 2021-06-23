//
//  Extension.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 27/02/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showActivityIndicator(uiView: UIView) {
        
        let backgroundview = UIView.init(frame: CGRect.init(x: 0, y: 0, width:  view.frame.size.width, height:  view.frame.size.height))
        backgroundview.tag=1024;
        backgroundview.backgroundColor = UIColor.init(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 0.4)
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actInd.center = uiView.center
        if #available(iOS 13, *) {
            actInd.style = UIActivityIndicatorView.Style.large
        } else {
            actInd.style = UIActivityIndicatorView.Style.whiteLarge
        }
        actInd.color = UIColor.darkGray
        actInd.startAnimating()
        backgroundview.addSubview(actInd)
        view.addSubview(backgroundview)
    }
    func hideActivityIndicator(uiView: UIView) {
        view.viewWithTag(1024)?.removeFromSuperview()
    }
}
extension UIViewController {
    func isValidEmail(_ testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
        
    }
}
extension UIAlertController{
    static func alertWithTitle(title: String, message: String, buttonTitle: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alertController.addAction(action)
        return alertController
    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )
        
        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )
        
        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}
class HelpingMethods{
    
    static  let sharedInstance = HelpingMethods()
    
    func getCurrentDateTime() -> (date: String, time: String){
        
        let date = Date()
        let calendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        let dateTimeComponents = calendar.dateComponents(requestedComponents, from: date)
        let year = String(dateTimeComponents.year!)
        let month = String(dateTimeComponents.month!)
        let day = String(dateTimeComponents.day!)
        let hour = String(dateTimeComponents.hour!)
        let minute = String(dateTimeComponents.minute!)
        return ("\(day)-\(month)-\(year)", "\(hour):\(minute)")
        //        return ("\(year):\(month):\(day)", "\(hour):\(minute)")
    }
    
    func convertDateToString(date: Date, fromDateFormatter: String, toDateFormatter: String) -> String{
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = fromDateFormatter
        let myString = formatter.string(from: date) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = toDateFormatter
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        return myStringafd
    }
}
