//
//  VendorFilterModel.swift
//  WedAdvisor
//
//  Created by WishACloud on 01/07/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation


struct VendorsFilterModel: Codable {
    var vendorTypes: [VendorTypeData]?
    var vendorsInfo: VendorsInfo?
    var venues: [VenueLocation]?
    var amenities: [Amenity]?
    var socialLinks: [SocialLink]?

    enum CodingKeys: String, CodingKey {
        case vendorTypes = "vendor_types"
        case vendorsInfo, venues, amenities
        case socialLinks = "social_links"
    }
}

// MARK: - Amenity
struct Amenity: Codable {
    var id, vendorTypeID: Int?
    var amenitiesOption: String?
    var createdAt, updatedAt: String?
    var deletedAt: String?
    var isSelected: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case vendorTypeID = "vendor_type_id"
        case amenitiesOption = "amenities_option"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}


// MARK: - VenueLocation
struct VenueLocation: Codable {
    var id: Int?
    var name: String?
    var url: String?
    var createdAt, updatedAt: String?
    var deletedAt: String?
    var logo, city: String?
    var isSelected: Bool = false

    enum CodingKeys: String, CodingKey {
        case id, name, url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case logo, city
    }
}

// MARK: - SocialLink
struct SocialLink: Codable {
    var id: Int?
    var name: String?
    var url: String?
    var createdAt, updatedAt: String?
    var deletedAt: String?
    var logo, city: String?

    enum CodingKeys: String, CodingKey {
        case id, name, url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case logo, city
    }
}

// MARK: - VendorTypeData
struct VendorTypeData: Codable {
    var id: Int?
    var name: String?
    var url: String?
    var createdAt, updatedAt: String?
    var deletedAt: String?
    var logo, city: String?
    var isSelected: Bool = false

    enum CodingKeys: String, CodingKey {
        case id, name, url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case logo, city
    }
}


// MARK: - VendorsInfo
struct VendorsInfo: Codable {
    var currentPage: Int?
    var data: [VendorInfoData]?
    var firstPageURL: String?
    var from, lastPage: Int?
    var lastPageURL: String?
    var nextPageURL: String?
    var path: String?
    var perPage: Int?
    var prevPageURL: String?
    var to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - Datum
struct VendorInfoData: Codable {
    var id: Int?
    var name, email: String?
    var vendorTypeID: Int?
    var avgRating: String?
    var emailVerifiedAt, rememberToken: String?
    var createdAt, updatedAt: String?
    var deletedAt, department: String?
    var phone: String?
    var mobile, fax, assistantName, assistantPhone: String?
    var street, state, zipCode: String?
    var notes: String?
    var city: Int?
    var profileImage: String?
    var birthDate: String?
    var lang, lat: String?
    var basePrice: Int?
    var basePriceUnit: String?
    var status, countUserReview: Int?
    var isWishlist: Bool?
    var vendortype: SocialLink?
    var getreating: GetReatingModel?
    var getcity: SocialLink?
    var isSelected: Bool = false

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case vendorTypeID = "vendor_type_id"
        case avgRating = "avg_rating"
        case emailVerifiedAt = "email_verified_at"
        case rememberToken = "remember_token"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case department, phone, mobile, fax
        case assistantName = "assistant_name"
        case assistantPhone = "assistant_phone"
        case street, state
        case zipCode = "zip_code"
        case notes, city
        case profileImage = "profile_image"
        case birthDate = "birth_date"
        case lang, lat
        case basePrice = "base_price"
        case basePriceUnit = "base_price_unit"
        case status
        case countUserReview = "count_user_review"
        case isWishlist = "is_wishlist"
        case vendortype, getreating, getcity
    }
}


// MARK: - Getreating
struct GetReatingModel: Codable {
    var id, vendorID, userID: Int?
    var comment, rating: String?
    var pinFlag: String?
    var createdAt, updatedAt: String?
    var deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case vendorID = "vendor_id"
        case userID = "user_id"
        case comment, rating
        case pinFlag = "pin_flag"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}
