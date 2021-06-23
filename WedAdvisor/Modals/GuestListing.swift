//
//  GuestListing.swift
//  WedAdvisor
//
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
struct GuestListingData: Codable {
    var status : Int?
    var guest : GuestListingDataDetail?
    
    enum codingKeys: String, CodingKey{
       case status = "status"
        case guest = "guest"
       
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        status = try? (values.decodeIfPresent(Int.self,forKey: .status))
        guest = try? (values.decodeIfPresent(GuestListingDataDetail.self,forKey: .guest))
     
    }
}

struct GuestListingDataDetail: Codable {
    var data : [GuestDetail]?
    
    enum codingKeys: String, CodingKey{
        case data = "data"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        data = try? (values.decodeIfPresent([GuestDetail].self,forKey: .data))
     
    }
}


struct GuestDetail: Codable {
    var id : Int?
    var email : String?
    var relation : GuestRelation?
    var gueststatus : GuestStatus?
    var guest_one : String?
    
    enum codingKeys: String, CodingKey{
        case id = "id"
       case email = "email"
        case relation = "relation"
        case gueststatus = "gueststatus"
        case guest_one = "guest_one"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        email = try? (values.decodeIfPresent(String.self,forKey: .email))
        relation = try? (values.decodeIfPresent(GuestRelation.self,forKey: .relation))
        gueststatus = try? (values.decodeIfPresent(GuestStatus.self,forKey: .gueststatus))
        guest_one = try? (values.decodeIfPresent(String.self,forKey: .guest_one))
    }
}
struct GuestRelation: Codable {
    var id : Int?
    var name : String?
    
    enum codingKeys: String, CodingKey{
        case id = "id"
        case name = "name"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        name = try? (values.decodeIfPresent(String.self,forKey: .name))
    }
}

struct GuestStatus: Codable {
    var id : Int?
    var status_name : String?
    
    enum codingKeys: String, CodingKey{
        case id = "id"
        case status_name = "status_name"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        status_name = try? (values.decodeIfPresent(String.self,forKey: .status_name))
    }
}
