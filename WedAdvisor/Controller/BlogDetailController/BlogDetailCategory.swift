//
//  BlogDetailCategory.swift
//  WedAdvisor
//

//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class BlogDetailCategory: UICollectionViewCell {
    @IBOutlet weak var selectOptionsLbl: UILabel!
       @IBOutlet weak var viewBack: UIView!
    override var isSelected: Bool{
        didSet{
            if self.isSelected
            {
                super.isSelected = true
                viewBack.backgroundColor = .white
                viewBack.layer.borderColor = UIColor(red:26/255, green:163/255, blue:163/255, alpha:1).cgColor
                viewBack.layer.borderWidth = 0.5
                selectOptionsLbl.textColor = UIColor(red:26/255, green:163/255, blue:163/255, alpha:1)
            }
            else
            {
                super.isSelected = false
                viewBack.backgroundColor = UIColor.white
                selectOptionsLbl.textColor = UIColor(red:26/255, green:163/255, blue:163/255, alpha:1)

            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
         viewBack.layer.cornerRadius = viewBack.frame.size.height/2
    }

}
