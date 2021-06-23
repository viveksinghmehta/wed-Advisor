//
//  CategoryCollectionCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandy on 14/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imgImage: UIImageView!
   // @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewImage: SwiftShadowImageView!
    var arrPopularCat : [HomeVendorType]?
    override func awakeFromNib() {
        super.awakeFromNib()
      // imgImage.layer.cornerRadius = imgImage.frame.height/2
        viewImage.layer.cornerRadius = viewImage.frame.height/2
        
    }

}
extension UIImageView {
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 2
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
}
