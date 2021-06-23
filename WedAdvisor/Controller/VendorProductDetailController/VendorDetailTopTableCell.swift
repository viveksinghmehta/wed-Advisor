//
//  VendorDetailTopTableCell.swift
//  WedAdvisor

//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class VendorDetailTopTableCell: UITableViewCell {
    @IBOutlet weak var hotelNameLbl: UILabel!
      @IBOutlet weak var starCountLbl: UILabel!
      @IBOutlet weak var countryNameLbl: UILabel!
      @IBOutlet weak var hotelInfoLbl: UILabel!
      @IBOutlet weak var priceLbl: UILabel!
      @IBOutlet weak var reviewCountLbl: UILabel!
      @IBOutlet weak var starView: UIView!
    @IBOutlet weak var backButton: UIButton!
    var backClosure : (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        addBlurButton()
    }
    
    fileprivate func addBlurButton() {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.light))
        backButton.insertSubview(blur, at: 0)
        backButton.layer.cornerRadius = 20
        backButton.clipsToBounds = true
    }
    
    
    //MARK:- Button Outlets
    @IBAction func backBtn(sender: UIButton) {
        backClosure!()
       }
       
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
