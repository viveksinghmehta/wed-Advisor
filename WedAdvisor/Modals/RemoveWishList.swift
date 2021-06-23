//
//  RemoveWishList.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 06/04/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
struct RemoveWish: Codable {
    var status : Int?
    //var state : String?
    
    enum codingKeys: String, CodingKey{
      //  case name = "name"
        case status = "status"
       
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        status = try? (values.decodeIfPresent(Int.self,forKey: .status))
       // state = try? (values.decodeIfPresent(String.self,forKey: .state))
    }
}
