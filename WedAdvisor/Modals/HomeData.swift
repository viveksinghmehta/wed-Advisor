//
//  HomeData.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 27/02/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation


struct HomeData: Codable {
    
    var vendor_types: [HomeVendor]?
    var locations: [HomeLocation]?
    var homepageDetails: [HomeDetail]?
    var banner: [HomeBanner]?
    var social_links: [HomeSocial]?
    
    
    enum codingKeys: String, CodingKey{
        case vendor_types = "vendor_types"
        case locations = "locations"
        case homepageDetails = "homepageDetails"
        case banner = "banner"
        case social_links = "social_links"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        vendor_types = try? (values.decodeIfPresent([HomeVendor].self,forKey: .vendor_types))
        locations = try? (values.decodeIfPresent([HomeLocation].self,forKey: .locations))
        homepageDetails = try? (values.decodeIfPresent([HomeDetail].self,forKey: .homepageDetails))
        banner = try? (values.decodeIfPresent([HomeBanner].self,forKey: .banner))
        social_links = try? (values.decodeIfPresent([HomeSocial].self,forKey: .social_links))
        
        
    }
}

struct HomeVendor: Codable {
    
    var id: Int?
    var name: String?
    var logo: String?
    var created_at: String?
    var updated_at: String?
    
    
    enum codingKeys: String, CodingKey{
        
        case id = "id"
        case name = "name"
        case logo = "logo"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        name = try? (values.decodeIfPresent(String.self,forKey: .name))
        logo = try? (values.decodeIfPresent(String.self,forKey: .logo))
        created_at = try? (values.decodeIfPresent(String.self,forKey: .created_at))
        updated_at = try? (values.decodeIfPresent(String.self,forKey: .updated_at))
        
        
    }
}

struct HomeLocation: Codable {
    var id : Int?
    var city : String?
    enum codingKeys: String, CodingKey{
    
        case city = "city"
        case id = "id"
    }
    init(from decoder: Decoder) throws {
           let values = try decoder.container(keyedBy: codingKeys.self)
           city = try? (values.decodeIfPresent(String.self,forKey: .city))
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
}
}

struct HomeDetail: Codable {
    
    var id: Int?
    var type_id: Int?
    var position: Int?
    var status: Int?
    var title: String?
    var sub_title: String?
    var list_con: [Int]?
    var items: Int?
    var created_at: String?
    var updated_at: String?
    var itemlist: [HomeItemList]?
    var types: [HomeType]?
    var vendor_type: [HomeVendorType]?
    var testimonials : [GetTestimonial]?
    var location : [GetLocation]?
    var howitwork : [GetHowWork]?
    var weddTipsNews : [GetweddTipsNews]?
    enum codingKeys: String, CodingKey{
        
        case id = "id"
        case type_id = "type_id"
        case position = "position"
        case status = "status"
        case title = "title"
        case sub_title = "sub_title"
        case list_con = "list_con"
        case items = "items"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case itemlist = "itemlist"
        case types = "types"
        case vendor_type = "vendor_type"
        case testimonials = "testimonials"
        case location = "location"
        case howitwork = "howitwork"
        case weddTipsNews = "weddTipsNews"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        type_id = try? (values.decodeIfPresent(Int.self,forKey: .type_id))
        position = try? (values.decodeIfPresent(Int.self,forKey: .position))
        status = try? (values.decodeIfPresent(Int.self,forKey: .status))
        title = try? (values.decodeIfPresent(String.self,forKey: .title))
        sub_title = try? (values.decodeIfPresent(String.self,forKey: .sub_title))
        list_con = try? (values.decodeIfPresent([Int].self,forKey: .list_con))
        items = try? (values.decodeIfPresent(Int.self,forKey: .items))
        created_at = try? (values.decodeIfPresent(String.self,forKey: .created_at))
        updated_at = try? (values.decodeIfPresent(String.self,forKey: .updated_at))
        itemlist = try? (values.decodeIfPresent([HomeItemList].self,forKey: .itemlist))
        types = try? (values.decodeIfPresent([HomeType].self,forKey: .types))
        vendor_type = try? (values.decodeIfPresent([HomeVendorType].self,forKey: .vendor_type))
       testimonials = try? (values.decodeIfPresent([GetTestimonial].self,forKey: .testimonials))
        location = try? (values.decodeIfPresent([GetLocation].self,forKey: .location))
       howitwork = try? (values.decodeIfPresent([GetHowWork].self,forKey: .howitwork ))
        weddTipsNews = try? (values.decodeIfPresent([GetweddTipsNews].self,forKey: .weddTipsNews ))
    }
}

struct HomeBanner: Codable {
    var id: Int?
    var image: String?
    var created_at: String?
    var updated_at: String?
    
    
    enum codingKeys: String, CodingKey{
        case id = "id"
        case image = "image"
        case created_at = "created_at"
        case updated_at = "updated_at"
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        image = try? (values.decodeIfPresent(String.self,forKey: .image))
        created_at = try? (values.decodeIfPresent(String.self,forKey: .created_at))
        updated_at = try? (values.decodeIfPresent(String.self,forKey: .updated_at))
    }
}


struct HomeSocial: Codable {
}

struct HomeItemList: Codable {
    
    var id: Int?
    var name: String?
    var email: String?
    var vendor_type_id: Int?
    var avg_rating: String?
    var created_at: String?
    var updated_at: String?
    var phone: String?
    var state: String?
    var notes: String?
    var city: Int?
    var profile_image: String?
    var lang: String?
    var lat: String?
    var base_price: Int?
    var base_price_unit: String?
    var city_name: String?
    var vendortype: HomeVendorType?
    var getreating: Getreating?
    var is_wishlist : Bool?
    enum codingKeys: String, CodingKey{
        
        case id = "id"
        case name = "name"
        case email = "email"
        case vendor_type_id = "vendor_type_id"
        case avg_rating = "avg_rating"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case phone = "phone"
        case state = "state"
        case notes = "notes"
        case city = "city"
        case profile_image = "profile_image"
        case lang = "lang"
        case lat = "lat"
        case base_price = "base_price"
        case city_name = "city_name"
        case vendortype = "vendortype"
        case getreating = "getreating"
        case base_price_unit = "base_price_unit"
        case is_wishlist = "is_wishlist"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        name = try? (values.decodeIfPresent(String.self,forKey: .name))
        email = try? (values.decodeIfPresent(String.self,forKey: .email))
        base_price_unit = try? (values.decodeIfPresent(String.self,forKey: .base_price_unit))
        vendor_type_id = try? (values.decodeIfPresent(Int.self,forKey: .vendor_type_id))
        avg_rating = try? (values.decodeIfPresent(String.self,forKey: .avg_rating))
        created_at = try? (values.decodeIfPresent(String.self,forKey: .created_at))
        updated_at = try? (values.decodeIfPresent(String.self,forKey: .updated_at))
        phone = try? (values.decodeIfPresent(String.self,forKey: .phone))
        state = try? (values.decodeIfPresent(String.self,forKey: .state))
        notes = try? (values.decodeIfPresent(String.self,forKey: .notes))
        city = try? (values.decodeIfPresent(Int.self,forKey: .city))
        profile_image = try? (values.decodeIfPresent(String.self,forKey: .profile_image))
        lang = try? (values.decodeIfPresent(String.self,forKey: .lang))
        lat = try? (values.decodeIfPresent(String.self,forKey: .lat))
        base_price = try? (values.decodeIfPresent(Int.self,forKey: .base_price))
        city_name = try? (values.decodeIfPresent(String.self,forKey: .city_name))
        vendortype = try? (values.decodeIfPresent(HomeVendorType.self,forKey: .vendortype))
        getreating = try? (values.decodeIfPresent(Getreating.self,forKey: .getreating))
        is_wishlist = try? (values.decodeIfPresent(Bool.self,forKey: .is_wishlist))
        
    }
}


struct HomeType: Codable {
    
    var id: Int?
    var type: String?
    var created_at: String?
    var updated_at: String?
    
    
    enum codingKeys: String, CodingKey{
        
        case id = "id"
        case type = "type"
        case created_at = "created_at"
        case updated_at = "updated_at"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        type = try? (values.decodeIfPresent(String.self,forKey: .type))
        created_at = try? (values.decodeIfPresent(String.self,forKey: .created_at))
        updated_at = try? (values.decodeIfPresent(String.self,forKey: .updated_at))
    }
}



struct HomeVendorType: Codable {
    
    var id: Int?
    var name: String?
    var logo: String?
    var created_at: String?
    var updated_at: String?
    var city : String?
    
    enum codingKeys: String, CodingKey{
        
        case id = "id"
        case name = "name"
        case logo = "logo"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case city = "city"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        name = try? (values.decodeIfPresent(String.self,forKey: .name))
        logo = try? (values.decodeIfPresent(String.self,forKey: .logo))
        created_at = try? (values.decodeIfPresent(String.self,forKey: .created_at))
        updated_at = try? (values.decodeIfPresent(String.self,forKey: .updated_at))
        city = try? (values.decodeIfPresent(String.self,forKey: .city))
    }
}




struct Getreating: Codable {
    
    var id: Int?
    var vendor_id: Int?
    var user_id: Int?
    var comment: String?
    var rating: String?
    var created_at: String?
    var updated_at: String?
    
    enum codingKeys: String, CodingKey{
        
        case id = "id"
        case vendor_id = "vendor_id"
        case user_id = "user_id"
        case comment = "comment"
        case rating = "rating"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        vendor_id = try? (values.decodeIfPresent(Int.self,forKey: .vendor_id))
        user_id = try? (values.decodeIfPresent(Int.self,forKey: .user_id))
        comment = try? (values.decodeIfPresent(String.self,forKey: .comment))
        rating = try? (values.decodeIfPresent(String.self,forKey: .rating))
        created_at = try? (values.decodeIfPresent(String.self,forKey: .created_at))
        updated_at = try? (values.decodeIfPresent(String.self,forKey: .updated_at))
    }
}


struct GetTestimonial: Codable {
    
    var id: Int?
    var comment: String?
    var name : String?
    var profession: String?
    var created_at: String?
    var updated_at: String?
    var profile_image : String?
    enum codingKeys: String, CodingKey{
        
        case id = "id"
        case comment = "comment"
        case profession = "profession"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case name = "name"
        case profile_image = "profile_image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        comment = try? (values.decodeIfPresent(String.self,forKey: .comment))
        profession = try? (values.decodeIfPresent(String.self,forKey: .profession))
        created_at = try? (values.decodeIfPresent(String.self,forKey: .created_at))
        updated_at = try? (values.decodeIfPresent(String.self,forKey: .updated_at))
        name = try? (values.decodeIfPresent(String.self,forKey: .name))
       profile_image = try? (values.decodeIfPresent(String.self,forKey: .profile_image))
    }
}

struct GetLocation: Codable {
    
    var location: HomeVendorType?
    var vendors: Int?
   
    enum codingKeys: String, CodingKey{
        
        case location = "location"
        case vendors = "vendors"
       
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        location = try? (values.decodeIfPresent(HomeVendorType.self,forKey: .location))
        vendors = try? (values.decodeIfPresent(Int.self,forKey: .vendors))
       
    }
}


struct GetHowWork: Codable {
    
    var id: Int?
    var header: String?
   
    enum codingKeys: String, CodingKey{
        
        case id = "id"
        case header = "header"
       
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        header = try? (values.decodeIfPresent(String.self,forKey: .header))
       
    }
}


struct GetweddTipsNews: Codable {
    
    var id: Int?
    var title: String?
    var description: String?
    var short_description: String?
    var cover_image: String?
    var created_at: String?
    var updated_at: String?
    var author : String?
    
    enum codingKeys: String, CodingKey{
        
        case id = "id"
        case title = "title"
        case description = "description"
        case short_description = "short_description"
        case cover_image = "cover_image"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case author = "author"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        title = try? (values.decodeIfPresent(String.self,forKey: .title))
        description = try? (values.decodeIfPresent(String.self,forKey: .description))
        short_description = try? (values.decodeIfPresent(String.self,forKey: .short_description))
        created_at = try? (values.decodeIfPresent(String.self,forKey: .created_at))
        updated_at = try? (values.decodeIfPresent(String.self,forKey: .updated_at))
        cover_image = try? (values.decodeIfPresent(String.self,forKey: .cover_image))
        author = try? (values.decodeIfPresent(String.self,forKey: .author))
    }
}
