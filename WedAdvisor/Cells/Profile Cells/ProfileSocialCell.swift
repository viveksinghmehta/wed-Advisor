//
//  ProfileSocialCell.swift
//  WedAdvisor
//
//  Created by WishACloud on 26/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class ProfileSocialCell: UITableViewCell {

    @IBOutlet weak var backContentView: UIView!
    @IBOutlet weak var facebookImageView: UIImageView!
    @IBOutlet weak var twitterImageView: UIImageView!
    @IBOutlet weak var youtubeImageView: UIImageView!
    @IBOutlet weak var instagramImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        facebookImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(facebookAction(_:))))
        twitterImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(twitterAction(_:))))
        youtubeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(youtubeAction(_:))))
        instagramImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(instagramAction(_:))))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc fileprivate func facebookAction(_ sender: UITapGestureRecognizer) {
        print("facebook")
    }
    
    @objc fileprivate func twitterAction(_ sender: UITapGestureRecognizer) {
        print("twitter")
    }
    
    @objc fileprivate func youtubeAction(_ sender: UITapGestureRecognizer) {
        print("youtube")
    }
    
    
    @objc fileprivate func instagramAction(_ sender: UITapGestureRecognizer) {
        print("instagram")
    }
    
    
}
