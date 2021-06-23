//
//  VendorDetail.swift
//  WedAdvisor
//
//  Created by Vishal Pandeyon 02/03/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
struct VedorDetail: Codable {
    var vendor_types : [HomeVendorType]?
    var vendor: VedorDetailData?
    var similarVendors : [HomeItemList]?
    var amenities : [amenitiesData]?
    var vendorAmenities : [amenitiesData]?
    var ratingTypes : [amenitiesRatingData]?
    var vendor_slider_imgs : [amenitiesSliderImage]?
    var vendorQuestions : [VedorDetailQuestionsAns]?
    enum codingKeys: String, CodingKey{
        case vendor_types = "vendor_types"
        case vendor = "vendor"
        case similarVendors = "similarVendors"
        case amenities = "amenities"
        case ratingTypes = "ratingTypes"
        case vendor_slider_imgs = "vendor_slider_imgs"
        case vendorAmenities = "vendorAmenities"
        case vendorQuestions = "vendorQuestions"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        vendor_types = try? (values.decodeIfPresent([HomeVendorType].self,forKey: .vendor_types))
        vendor = try? (values.decodeIfPresent(VedorDetailData.self,forKey: .vendor))
        similarVendors  = try? (values.decodeIfPresent([HomeItemList].self,forKey: .similarVendors))
        amenities = try? (values.decodeIfPresent([amenitiesData].self,forKey: .amenities))
        ratingTypes = try? (values.decodeIfPresent([amenitiesRatingData].self,forKey: .ratingTypes))
        vendor_slider_imgs = try? (values.decodeIfPresent([amenitiesSliderImage].self,forKey: .vendor_slider_imgs))
        vendorAmenities = try? (values.decodeIfPresent([amenitiesData].self,forKey: .vendorAmenities))
        vendorQuestions = try? (values.decodeIfPresent([VedorDetailQuestionsAns].self,forKey: .vendorQuestions))
    }
}

struct VedorDetailData: Codable {
    
    var id: Int?
    var name: String?
    var email: String?
    var phone: String?
    var street: String?
    var zip_code: String?
    var notes : String?
    var profile_image : String?
    var getcity : CityData?
    var avg_rating : Int?
    var count_user_review : Int?
    var base_price : Int?
    
    enum codingKeys: String, CodingKey{
        
        case id = "id"
        case name = "name"
        case email = "email"
        case phone = "phone"
        case street = "street"
        case zip_code = "zip_code"
        case notes = "notes"
        case profile_image = "profile_image"
        case getcity = "getcity"
        case avg_rating = "avg_rating"
        case count_user_review = "count_user_review"
        case base_price = "base_price"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        name = try? (values.decodeIfPresent(String.self,forKey: .name))
        email = try? (values.decodeIfPresent(String.self,forKey: .email))
        phone = try? (values.decodeIfPresent(String.self,forKey: .phone))
        street = try? (values.decodeIfPresent(String.self,forKey: .street))
        zip_code = try? (values.decodeIfPresent(String.self,forKey: .zip_code))
        notes = try? (values.decodeIfPresent(String.self,forKey: .notes))
        profile_image = try? (values.decodeIfPresent(String.self,forKey: .profile_image))
        getcity = try? (values.decodeIfPresent(CityData.self,forKey: .getcity))
        avg_rating = try? (values.decodeIfPresent(Int.self,forKey: .avg_rating))
        count_user_review = try? (values.decodeIfPresent(Int.self,forKey: .count_user_review))
        base_price = try? (values.decodeIfPresent(Int.self,forKey: .base_price))
    }
}
struct CityData: Codable {
    var id: Int?
    var logo: String?
    var city : String?
    enum codingKeys: String, CodingKey{
        case id = "id"
        case logo = "logo"
        case city = "city"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        logo = try? (values.decodeIfPresent(String.self,forKey: .logo))
        city = try? (values.decodeIfPresent(String.self,forKey: .city))
    }
}
struct amenitiesData: Codable {
    
    var id: Int?
    var vendor_type_id: Int?
    var amenities_option: String?
    var status : String?
    var amenities_id : Int?
    
    enum codingKeys: String, CodingKey{
        
        case id = "id"
        case vendor_type_id = "vendor_type_id"
        case amenities_option = "amenities_option"
        case status = "status"
        case amenities_id = "amenities_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        vendor_type_id = try? (values.decodeIfPresent(Int.self,forKey: .vendor_type_id))
        amenities_option = try? (values.decodeIfPresent(String.self,forKey: .amenities_option))
        status = try? (values.decodeIfPresent(String.self,forKey: .status))
        amenities_id = try? (values.decodeIfPresent(Int.self,forKey: .amenities_id))
        
    }
}

struct amenitiesRatingData: Codable {
    
    var id: Int?
    var rating_name: String?
    var created_at : String?
    
    enum codingKeys: String, CodingKey{
        
        case id = "id"
        case rating_name = "rating_name"
        case created_at = "created_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        rating_name = try? (values.decodeIfPresent(String.self,forKey: .rating_name))
        created_at = try? (values.decodeIfPresent(String.self,forKey: .created_at))
        
    }
}

struct amenitiesSliderImage: Codable {
    var image: String?
    enum codingKeys: String, CodingKey{
        case image = "image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        image = try? (values.decodeIfPresent(String.self,forKey: .image))
        
    }
}

struct VedorDetailQuestionsAns: Codable {
    
    var id: Int?
    var answere_q: String?
    var vendorquestion: VedorDetailQuestions?
    
    enum codingKeys: String, CodingKey{
        
        case id = "id"
        case answere_q = "answere_q"
        case vendorquestion = "vendorquestion"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        answere_q = try? (values.decodeIfPresent(String.self,forKey: .answere_q))
        vendorquestion = try? (values.decodeIfPresent(VedorDetailQuestions.self,forKey: .vendorquestion))
        
    }
}

struct VedorDetailQuestions: Codable {
    
    var id: Int?
    var question: String?
    
    enum codingKeys: String, CodingKey{
        
        case id = "id"
        case question = "question"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        question = try? (values.decodeIfPresent(String.self,forKey: .question))
        
    }
}
