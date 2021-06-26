//
//  MyProfileModel.swift
//  WedAdvisor
//
//  Created by Vishal Pandeyon 07/04/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
struct MyProfileModel: Codable {
    var loggedUser : LoggedUserInfo?
    var usermobile : [usermobileInfo]?
    enum codingKeys: String, CodingKey{
        case loggedUser = "loggedUser"
        case usermobile = "usermobile"
       
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        loggedUser = try? (values.decodeIfPresent(LoggedUserInfo.self,forKey: .loggedUser))
        usermobile = try? (values.decodeIfPresent([usermobileInfo].self,forKey: .usermobile))
    }
}
struct LoggedUserInfo: Codable {
    var name : String?
    var email : String?
    var phone : String?
    var profile_image : String?
    var description : String?
    
enum codingKeys: String, CodingKey{
        case name = "name"
       case email = "email"
        case phone = "phone"
        case profile_image = "profile_image"
        case description = "description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        name = try? (values.decodeIfPresent(String.self,forKey: .name))
        email = try? (values.decodeIfPresent(String.self,forKey: .email))
        phone = try? (values.decodeIfPresent(String.self,forKey: .phone))
        profile_image = try? (values.decodeIfPresent(String.self,forKey: .profile_image))
        description = try? (values.decodeIfPresent(String.self,forKey: .description))

    }
}

struct usermobileInfo: Codable {
    var id : Int?
    var mobile : String?
    var is_active : Int?
   
enum codingKeys: String, CodingKey{
        case id = "id"
        case mobile = "mobile"
        case is_active = "is_active"
       
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self, forKey: .id))
        mobile = try? (values.decodeIfPresent(String.self, forKey: .mobile))
        is_active = try? (values.decodeIfPresent(Int.self, forKey: .is_active))


    }
}
