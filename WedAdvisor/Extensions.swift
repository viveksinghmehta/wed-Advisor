//
//  Extensions.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 13/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//



//Shadow
import Foundation
import UIKit


//Shadow
extension UIView {
    func dropShadow(shadow_color: UIColor,offset: CGSize,shadow_radius: CGFloat,shadow_opacity: Float,corner_radius: CGFloat) {
        self.layer.shadowColor = shadow_color.cgColor
        self.layer.shadowOpacity = shadow_opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = shadow_radius
        self.layer.cornerRadius = corner_radius
    }
    
    
}

extension UIView {
   func setShadowToUIView(shadowColor:UIColor){
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2
        layer.shadowOpacity = 1.0
        clipsToBounds = false
        layer.masksToBounds = false
    }
    
    
}





extension UIView {

    func roundCorners(corners:UIRectCorner, radius: CGFloat) {

        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
}

extension UIView {

func addTopRoundedCornerToViewNew(targetView:UIView?, desiredCurve:CGFloat?)
{
    let offset:CGFloat =  targetView!.frame.width/desiredCurve!
    let bounds: CGRect = targetView!.bounds

    let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y+bounds.size.height / 2, width: bounds.size.width, height: bounds.size.height / 2)

    let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
    let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
    let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
    rectPath.append(ovalPath)

    // Create the shape layer and set its path
    let maskLayer: CAShapeLayer = CAShapeLayer()
    maskLayer.frame = bounds
    maskLayer.path = rectPath.cgPath

    // Set the newly created shape layer as the mask for the view's layer
    targetView!.layer.mask = maskLayer
}
}


func shadowImage(imgageView: UIImageView){
    var coverView: UIView?
    let screenRect = UIScreen.main.bounds
    coverView = UIView(frame: screenRect)
    coverView?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
   imgageView.addSubview(coverView!)
}

extension CATransition {
    
    //New viewController will appear from bottom of screen.
    func segueFromBottom() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromTop
        return self
    }
    //New viewController will appear from top of screen.
    func segueFromTop() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromBottom
        return self
    }
    //New viewController will appear from left side of screen.
    func segueFromLeft() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromLeft
        return self
    }
    
    //New viewController will appear from left side of screen.
    func segueFromRight() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromRight
        return self
    }
    
    //New viewController will pop from right side of screen.
    func popFromRight() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromRight
        return self
    }
    
    //New viewController will appear from left side of screen.
    func popFromLeft() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromLeft
        return self
    }
}

extension UIViewController {
    func nextMenu(indexMenu : Int){
        if indexMenu == 0{
            let vc = storyboard?.instantiateViewController(withIdentifier: "CoupleDashboardController") as! CoupleDashboardController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        else if indexMenu == 1{
            let vc = storyboard?.instantiateViewController(withIdentifier: "MyWishListController") as! MyWishListController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
            else if indexMenu == 2{
                let vc = storyboard?.instantiateViewController(withIdentifier: "ToDoListViewController") as! ToDoListViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
        else if indexMenu == 3{
            let vc = storyboard?.instantiateViewController(withIdentifier: "BudgetController") as! BudgetController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
            
        else if indexMenu == 4{
                let vc = storyboard?.instantiateViewController(withIdentifier: "GuestListController") as! GuestListController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
        else if indexMenu == 5{
            let vc = storyboard?.instantiateViewController(withIdentifier: "SeatingTableController") as! SeatingTableController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if indexMenu == 6{
            let vc = storyboard?.instantiateViewController(withIdentifier: "WeddingWebsiteController") as! WeddingWebsiteController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexMenu == 7{
            let vc = storyboard?.instantiateViewController(withIdentifier: "RealWeddingController") as! RealWeddingController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexMenu == 8{
             let vc = storyboard?.instantiateViewController(withIdentifier: "SelectOptionsController") as! SelectOptionsController
           self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexMenu == 9{
                   let vc = storyboard?.instantiateViewController(withIdentifier: "LogoutController") as! LogoutController
                   self.navigationController?.pushViewController(vc, animated: true)
               }
            else if indexMenu == 11{
//                              let vc = storyboard?.instantiateViewController(withIdentifier: "LogoutController") as! LogoutController
//                              self.navigationController?.pushViewController(vc, animated: true)
                          }
//        else if indexMenu == 100{
//              let vc = storyboard?.instantiateViewController(withIdentifier: "DashBoardController") as! DashBoardController
//                    self.navigationController?.pushViewController(vc, animated: true)
//        }
       
    }
}

extension UIView {
//    func addGradient(with layer: CAGradientLayer, gradientFrame: CGRect? = nil, colorSet: [UIColor],
//                     locations: [Double], startEndPoints: (CGPoint, CGPoint)? = nil) {
//        layer.frame = gradientFrame ?? self.bounds
//        layer.frame.origin = .zero
//
//        let layerColorSet = colorSet.map { $0.cgColor }
//        let layerLocations = locations.map { $0 as NSNumber }
//
//        layer.colors = layerColorSet
//        layer.locations = layerLocations
//
//        if let startEndPoints = startEndPoints {
//            layer.startPoint = startEndPoints.0
//            layer.endPoint = startEndPoints.1
//        }
//
//        self.layer.insertSublayer(layer, above: self.layer)
//    }
    
     func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
         let gradient: CAGradientLayer = CAGradientLayer()
         gradient.frame = self.bounds
         gradient.colors = colours.map { $0.withAlphaComponent(0.40).cgColor }
       gradient.locations = locations
        self.layer.addSublayer(gradient)
    }
}


enum Anchor { case left, top, right, bottom }
extension UIView {
    /**
    Description: Centers the view in the superview, using the superview's **size** and **XYAxis** position, not the left, top, right, bottom anchors to avoid issues with the *UISCrollViews*
    Parameters: None
    */
    func addAnchorsCenterAndFillContainer() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: self.superview!.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: self.superview!.centerYAnchor).isActive = true
    }

    /**
    Adds 2 optional alignment parameterts (**centerX**, **centerY**), 2 optional size dimensions (**width** and **height**) and up to 4 border anchors **.left**, **.top**, **.right** and **.bottom**. One of them (defined in **withAnchor** can be relative to another view

    - Parameter centerX: **Bool** value (or *nil*) to define if the view should be centered **horizontally** to the superview. (optional)
    - Parameter centerY: **Bool** value (or *nil*) to define if the view should be centered **vertically** to the superview. (optional)
    - Parameter width: The **width** of the view (optional)
    - Parameter width: The **width** of the view (optional)
    - Parameter height: The **height** of the view (optional)
    - Parameter left: The **left** margin to the superview
    - Parameter top: The **top** margin to the superview
    - Parameter right: The **right** margin to the superview. *Magniture adjusted to be positive for margins inside the view*
    - Parameter bottom: The **bottom** margin to the superview. *Magniture adjusted to be positive for margins inside the view*
    - Parameter withAnchor: The **Anchor** type that is relative to the **relativeToView** view. *This parameter can be omited*
    - Parameter relativeToView: The **UIView** object that is the reference for the **withAnchor** anchor. *This parameter can be omited*

    - Returns: None
    */
    func addAnchorsAndCenter(centerX: Bool?, centerY: Bool?, width: CGFloat?, height: CGFloat?, left: CGFloat?, top: CGFloat?, right: CGFloat?, bottom: CGFloat?, withAnchor: Anchor? = nil, relativeToView: UIView? = nil) {

        self.translatesAutoresizingMaskIntoConstraints = false
        if centerX != nil {
            if centerX! == true {
                self.centerXAnchor.constraint(equalTo: self.superview!.centerXAnchor).isActive = true
            }
        }
        if centerY != nil {
            if centerY! == true {
                self.centerYAnchor.constraint(equalTo: self.superview!.centerYAnchor).isActive = true
            }
        }

        self.addAnchorsAndSize(width: width, height: height, left: left, top: top, right: right, bottom: bottom, withAnchor: withAnchor, relativeToView: relativeToView)
    }

    /**
    Adds 2 optional size dimensions (**width** and **height**) and up to 4 border anchors **.left**, **.top**, **.right** and **.bottom**. One of them (defined in **withAnchor** can be relative to another view

    - Parameter width: The **width** of the view (optional)
    - Parameter height: The **height** of the view (optional)
    - Parameter left: The **left** margin to the superview
    - Parameter top: The **top** margin to the superview
    - Parameter right: The **right** margin to the superview. *Magniture adjusted to be positive for margins inside the view*
    - Parameter bottom: The **bottom** margin to the superview. *Magniture adjusted to be positive for margins inside the view*
    - Parameter withAnchor: The **Anchor** type that is relative to the **relativeToView** view. *This parameter can be omited*
    - Parameter relativeToView: The **UIView** object that is the reference for the **withAnchor** anchor. *This parameter can be omited*

    - Returns: None
    */
    func addAnchorsAndSize(width: CGFloat?, height: CGFloat?, left: CGFloat?, top: CGFloat?, right: CGFloat?, bottom: CGFloat?, withAnchor: Anchor? = nil, relativeToView: UIView? = nil) {

        self.translatesAutoresizingMaskIntoConstraints = false
        if width != nil {
            self.widthAnchor.constraint(equalToConstant: width!).isActive = true
        }
        if height != nil {
            self.heightAnchor.constraint(equalToConstant: height!).isActive = true
        }
        self.addAnchors(left: left, top: top, right: right, bottom: bottom, withAnchor: withAnchor, relativeToView: relativeToView)
    }

    /**
    Adds up to 4 border anchors **.left**, **.top**, **.right** and **.bottom**. One of them (defined in **withAnchor** can be relative to another view

    - Parameter left: The **left** margin to the superview
    - Parameter top: The **top** margin to the superview
    - Parameter right: The **right** margin to the superview. *Magniture adjusted to be positive for margins inside the view*
    - Parameter bottom: The **bottom** margin to the superview. *Magniture adjusted to be positive for margins inside the view*
    - Parameter withAnchor: The **Anchor** type that is relative to the **relativeToView** view. *This parameter can be omited*
    - Parameter relativeToView: The **UIView** object that is the reference for the **withAnchor** anchor. *This parameter can be omited*

    - Returns: None
    */
    func addAnchors(left: CGFloat?, top: CGFloat?, right: CGFloat?, bottom: CGFloat?, withAnchor: Anchor? = nil, relativeToView: UIView? = nil) {

        self.translatesAutoresizingMaskIntoConstraints = false
        let superView = self.superview!
        if withAnchor != nil && relativeToView != nil {
            /**
            * Anchors relative to oposite anchors of reference view
            **/
            switch withAnchor! {
            case .left:
                if left != nil {
                    self.leftAnchor.constraint(equalTo: relativeToView!.rightAnchor, constant: left!).isActive = true
                }
            case .top:
                if top != nil {
                    self.topAnchor.constraint(equalTo: relativeToView!.bottomAnchor, constant: top!).isActive = true
                }
            case .right:
                if right != nil {
                    self.rightAnchor.constraint(equalTo: relativeToView!.leftAnchor, constant: -right!).isActive = true
                }
            case .bottom:
                if bottom != nil {
                    self.bottomAnchor.constraint(equalTo: relativeToView!.topAnchor, constant: -bottom!).isActive = true
                }
            }
        }

        /**
        * Anchors relative to same anchors of superview
        **/
        if let _anchor = withAnchor {
            if _anchor == .left {
                if top != nil {
                    self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
                }
                if right != nil {
                    self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
                }
                if bottom != nil {
                    self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
                }
            }
            if _anchor == .top {
                if left != nil {
                    self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: left!).isActive = true
                }
                if right != nil {
                    self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
                }
                if bottom != nil {
                    self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
                }
            }
            if _anchor == .right {
                if left != nil {
                    self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: left!).isActive = true
                }
                if top != nil {
                    self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
                }
                if bottom != nil {
                    self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
                }
            }
            if _anchor == .bottom {
                if left != nil {
                    self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: (left!)).isActive = true
                }
                if top != nil {
                    self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
                }
                if right != nil {
                    self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
                }
            }
        } else {
            if left != nil {
                self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: left!).isActive = true
            }
            if top != nil {
                self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
            }
            if right != nil {
                self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
            }
            if bottom != nil {
                self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
            }
        }
    }
}

extension UIView{
func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
let border = UIView()

border.backgroundColor = color
border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
border.roundCorners(corners: [.topLeft, .topRight], radius: 20)
border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
addSubview(border)
}

func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
let border = UIView()
border.backgroundColor = color
border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
addSubview(border)
}

func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
let border = UIView()
border.backgroundColor = color
border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
addSubview(border)
}

func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
let border = UIView()
border.backgroundColor = color
border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
addSubview(border)
}


}
extension UIView {
func roundCornersNew(corners: UIRectCorner, radius: CGFloat) {
let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
let mask = CAShapeLayer()
mask.path = path.cgPath
layer.mask = mask
}
}
