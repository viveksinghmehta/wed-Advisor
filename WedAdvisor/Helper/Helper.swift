//
//  Helper.swift
//  WedAdvisor
//
//  Created by WishACloud on 14/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import Foundation

final class Helper {
    
    class func optionalIntToString(value: Int?) -> String {
        if let value = value {
            return value.description
        } else {
            return "0"
        }
    }
    
    class func optionalStringToString(value: String?) -> String {
        if let value = value {
            return value
        } else {
            return ""
        }
    }
    
    class func optionalStringDouble(value: String?) -> Double {
        if let value = value {
            guard let doubleValue = Double(value)?.rounded(.toNearestOrAwayFromZero) else { return 0.0 }
            return doubleValue
        } else {
            return 0.0
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}


extension UIImageView {
    
    func makeRounded(cornerRadius: CGFloat, color: UIColor = .black) {
        self.layer.borderWidth = 5
        self.layer.masksToBounds = false
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
}
