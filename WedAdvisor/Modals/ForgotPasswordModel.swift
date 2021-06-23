//
//  ForgotPasswordModel.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 02/04/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
struct forgotModel: Codable {
    var status : Int?
    var message: String?
 
    
    enum codingKeys: String, CodingKey{
        case status = "status"
        case message = "message"
      
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        status = try? (values.decodeIfPresent(Int.self,forKey: .status))
        message = try? (values.decodeIfPresent(String.self,forKey: .message))
       
    }
}
