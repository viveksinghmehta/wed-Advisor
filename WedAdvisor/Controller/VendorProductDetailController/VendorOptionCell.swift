//
//  VendorOptionCell.swift
//  WedAdvisor
//

//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class VendorOptionCell: UITableViewCell {
    @IBOutlet weak var optionSelectionView: UIView!
    @IBOutlet weak var reviewBtn: UIButton!
    @IBOutlet weak var aboutBtn: UIButton!
    @IBOutlet weak var gallaryBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK:- Button Outlets
    @IBAction func AboutBtnTapped(sender: UIButton) {
//         aboutContainerView.isHidden = false
//         reviewContainerView.isHidden = true
//         gallaryContainerView.isHidden = true
         
         self.aboutBtn.backgroundColor = WedAdviserColor.buttonselectBackgroundColor()
         self.reviewBtn.backgroundColor = WedAdviserColor.buttonUnselectBackgroundColor()
         self.gallaryBtn.backgroundColor = WedAdviserColor.buttonUnselectBackgroundColor()
         aboutBtn.setTitleColor(WedAdviserColor.buttonTextSelectionColor(), for: .normal)
         reviewBtn.setTitleColor(WedAdviserColor.buttonTextUnSelectColor(), for: .normal)
         gallaryBtn.setTitleColor(WedAdviserColor.buttonTextUnSelectColor(), for: .normal)
         
     }
    @IBAction func reviewBtnTapped(sender: UIButton) {
//           aboutContainerView.isHidden = true
//           reviewContainerView.isHidden = false
//           gallaryContainerView.isHidden = true
           self.reviewBtn.backgroundColor = WedAdviserColor.buttonselectBackgroundColor()
           self.aboutBtn.backgroundColor = WedAdviserColor.buttonUnselectBackgroundColor()
           self.gallaryBtn.backgroundColor = WedAdviserColor.buttonUnselectBackgroundColor()
           reviewBtn.setTitleColor(WedAdviserColor.buttonTextSelectionColor(), for: .normal)
           aboutBtn.setTitleColor(WedAdviserColor.buttonTextUnSelectColor(), for: .normal)
           gallaryBtn.setTitleColor(WedAdviserColor.buttonTextUnSelectColor(), for: .normal)
       }
       
       @IBAction func GallaryBtnTapped(sender: UIButton) {
//           aboutContainerView.isHidden = true
//           reviewContainerView.isHidden = true
//           gallaryContainerView.isHidden = false
           self.gallaryBtn.backgroundColor = WedAdviserColor.buttonselectBackgroundColor()
           self.reviewBtn.backgroundColor = WedAdviserColor.buttonUnselectBackgroundColor()
           self.aboutBtn.backgroundColor = WedAdviserColor.buttonUnselectBackgroundColor()
           reviewBtn.setTitleColor(WedAdviserColor.buttonTextUnSelectColor(), for: .normal)
           aboutBtn.setTitleColor(WedAdviserColor.buttonTextUnSelectColor(), for: .normal)
           gallaryBtn.setTitleColor(WedAdviserColor.buttonTextSelectionColor(), for: .normal)
           
       }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
