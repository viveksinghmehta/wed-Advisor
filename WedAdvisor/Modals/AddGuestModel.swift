//
//  AddGuestModel.swift
//  WedAdvisor
//
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
struct AddGuest: Codable {
    var status : Int?
    
    enum codingKeys: String, CodingKey{
       case status = "status"
       
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        status = try? (values.decodeIfPresent(Int.self,forKey: .status))
     
    }
}
