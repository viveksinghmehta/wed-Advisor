//
//  BlogListCell.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 15/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import EZYGradientView

class BlogListCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var shadowView: EZYGradientView!
    @IBOutlet weak var imgBlog: UIImageView!
    @IBOutlet weak var lblBlogName: UILabel!
    @IBOutlet weak var lblBlogList: UILabel!
    
    let gradientLayer = CAGradientLayer()

    override func awakeFromNib() {
        imgBlog.layer.masksToBounds = true
        imgBlog.layer.cornerRadius = 10;
        bgView.layer.cornerRadius = 10;
        shadowView.layer.cornerRadius = 10;
        self.shadowView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 17)

        super.awakeFromNib()
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
