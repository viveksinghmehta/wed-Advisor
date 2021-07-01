//
//  VendorFilter.swift
//  WedAdvisor
//
//  Created by Vishal Pandeyon 05/03/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation


struct VendorFilter: Codable {
    var vendor_types : [HomeVendorType]?
    var venues: [HomeVendorType]?
    var vendorsInfo : VendorInfo?
//    var amenities: [Amenity]?
    
    enum codingKeys: String, CodingKey {
        case vendor_types = "vendor_types"
        case venues = "venues"
        case vendorsInfo = "vendorsInfo"
        case amenties = "amenties"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        vendor_types = try? (values.decodeIfPresent([HomeVendorType].self, forKey: .vendor_types))
        venues = try? (values.decodeIfPresent([HomeVendorType].self, forKey: .venues))
        vendorsInfo  = try? (values.decodeIfPresent(VendorInfo.self, forKey: .vendorsInfo))
//        amenities = try? (values.decodeIfPresent([Amenity].self, forKey: .amenties))
    }
}

//struct Amenity: Codable {
//    var id, vendorTypeID: Int?
//    var amenitiesOption: String?
//    var createdAt, updatedAt: String?
//    var deletedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case vendorTypeID = "vendor_type_id"
//        case amenitiesOption = "amenities_option"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case deletedAt = "deleted_at"
//    }
//}


struct VendorInfo: Codable {
    var data : [VendorData]?
    var next_page_url : String?
    enum codingKeys: String, CodingKey{
        case data = "data"
        case next_page_url = "next_page_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        data = try? (values.decodeIfPresent([VendorData].self,forKey: .data))
        next_page_url = try? (values.decodeIfPresent(String.self,forKey: .next_page_url))
    }
}

struct VendorData: Codable {
    var id : Int?
    var name : String?
    var state : String?
    var avg_rating : Int?
    var is_wishlist : Bool?
    var profile_image : String?
    enum codingKeys: String, CodingKey{
        case name = "name"
        case state = "state"
        case id = "id"
        case avg_rating = "avg_rating"
         case is_wishlist = "is_wishlist"
        case profile_image = "profile_image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        name = try? (values.decodeIfPresent(String.self,forKey: .name))
        state = try? (values.decodeIfPresent(String.self,forKey: .state))
       id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        avg_rating = try? (values.decodeIfPresent(Int.self,forKey: .avg_rating))
        is_wishlist = try? (values.decodeIfPresent(Bool.self,forKey: .is_wishlist))
        profile_image = try? (values.decodeIfPresent(String.self,forKey: .profile_image))
    }
}
