//
//  SearchModel.swift
//  WedAdvisor
//
//  Created by WishACloud on 03/07/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation


struct SearchModel: Codable {
    var vendorType, location: [Location]?
    var search: String?
    var searchvendor: [Searchvendor]?

    enum CodingKeys: String, CodingKey {
        case vendorType = "vendor_type"
        case location, search, searchvendor
    }
}

// MARK: - Location
struct Location: Codable {
    var id: Int?
    var city, logo, createdAt, updatedAt: String?
    var deletedAt: String?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case id, city, logo
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case name
    }
}

// MARK: - Searchvendor
struct Searchvendor: Codable {
    var id: Int?
    var name, email: String?
    var vendorTypeID: Int?
    var avgRating: String?
    var emailVerifiedAt: String?
    var rememberToken: String?
    var createdAt, updatedAt: String?
    var deletedAt, department: String?
    var phone: String?
    var mobile, fax, assistantName, assistantPhone: String?
    var street, state, zipCode, notes: String?
    var city: Int?
    var profileImage: String?
    var birthDate: String?
    var lang: String?
    var lat: String?
    var basePrice: Int?
    var basePriceUnit: String?
    var status, countUserReview: Int?
    var isWishlist: Bool?

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
    }
}
