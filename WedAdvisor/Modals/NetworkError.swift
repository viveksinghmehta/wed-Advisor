//
//  NetworkError.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 27/02/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
struct NetworkError: Codable {
    
    var msg: String?
    var status: Int?
    var data: [ErrorData]?
    
    enum codingKeys: String, CodingKey{
        case msg = "message"
        case status = "status"
        case data = "data"
    }
    
    
    init(msg: String) {
        self.msg = msg
    }
    
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: codingKeys.self)
        msg = try? values.decodeIfPresent(String.self,forKey: .msg)
        status = try? values.decodeIfPresent(Int.self,forKey: .status)
        data = try? values.decodeIfPresent([ErrorData].self,forKey: .data)
    }
}

struct ErrorData : Codable {
    
}
