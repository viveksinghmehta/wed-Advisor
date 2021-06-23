//
//  SignUpModel.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 19/03/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
struct SignUp: Codable {
    var access_token : String?
    var token_type: String?
    var expires_in : Int?
    var email : [emailModel]?
    var error : String?
    
    enum codingKeys: String, CodingKey{
        case access_token = "access_token"
        case token_type = "token_type"
        case expires_in = "expires_in"
        case email = "email"
        case error = "error"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        access_token = try? (values.decodeIfPresent(String.self,forKey: .access_token))
        token_type = try? (values.decodeIfPresent(String.self,forKey: .token_type))
       expires_in  = try? (values.decodeIfPresent(Int.self,forKey: .expires_in))
        email = try? (values.decodeIfPresent([emailModel].self,forKey: .email))
        error = try? (values.decodeIfPresent(String.self,forKey: .error))
    }
}

struct emailModel: Codable {

    var email : String?
    
    enum codingKeys: String, CodingKey{
        case email = "email"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        email  = try? (values.decodeIfPresent(String.self,forKey: .email))
    }
}
