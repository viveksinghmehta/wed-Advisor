
//  Created by mac5 on 01/08/17.
//  Copyright © 2017 Braintechnosys pvt ltd. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    
    @IBOutlet var viewLbl: UIView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var imgArraow: UIImageView!
    @IBOutlet weak var leadingConst: NSLayoutConstraint!
    @IBOutlet weak var viewOuter: UIView!
   // @IBOutlet weak var topConst: NSLayoutConstraint!


    @IBOutlet var lblMenu: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
