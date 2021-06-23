//
//  AddPhoneModel.swift
//  WedAdvisor
//
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
struct AddPhone: Codable {
    var status : Int?
    var mobile : String?
    var selector : String?
    enum codingKeys: String, CodingKey{
        case status = "status"
       case mobile = "mobile"
        case selector = "selector"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        status = try? (values.decodeIfPresent(Int.self,forKey: .status))
        mobile = try? (values.decodeIfPresent(String.self,forKey: .mobile))
        selector = try? (values.decodeIfPresent(String.self,forKey: .selector))
    }
}
