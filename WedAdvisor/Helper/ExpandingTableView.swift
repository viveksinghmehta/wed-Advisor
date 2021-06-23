//
//  ExpandingTableView.swift
//  WedAdvisor
//
//  Created by WishACloud on 22/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import Foundation


class ExpandingTableView: UITableView {
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    
    override var contentSize: CGSize {
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }
}
