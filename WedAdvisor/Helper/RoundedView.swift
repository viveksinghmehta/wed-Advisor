//
//  RoundedView.swift
//  WedAdvisor
//
//  Created by WishACloud on 26/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import Foundation


final class RoundedView: UIView {
    
    private var shadowLayer: CAShapeLayer!

        override func layoutSubviews() {
            super.layoutSubviews()

            if shadowLayer == nil {
                shadowLayer = CAShapeLayer()
                shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 18).cgPath
                shadowLayer.fillColor = UIColor.white.cgColor

                shadowLayer.shadowColor = UIColor.black.cgColor
                shadowLayer.shadowPath = shadowLayer.path
                shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
                shadowLayer.shadowOpacity = 0.5
                shadowLayer.shadowRadius = 5

                layer.insertSublayer(shadowLayer, at: 0)
                //layer.insertSublayer(shadowLayer, below: nil) // also works
            }
        }
}
