//
//  OtpModel.swift
//  WedAdvisor
//
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
struct otpModel: Codable {
    var message : String?
//    var mobile : String?
//    var selector : String?
    enum codingKeys: String, CodingKey{
        case message = "message"
//       case mobile = "mobile"
       // case selector = "selector"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        message = try? (values.decodeIfPresent(String.self,forKey: .message))
//        mobile = try? (values.decodeIfPresent(String.self,forKey: .mobile))
//        selector = try? (values.decodeIfPresent(String.self,forKey: .selector))
    }
}
