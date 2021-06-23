//
//  BlogList.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 06/03/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
struct BlogList: Codable {
    var blogs : Blog?
    var recentBlogs: [GetweddTipsNews]?
  // var vendorsInfo : VendorInfo?
    var blogCategories : [BlogDetailCategories]?

    
    enum codingKeys: String, CodingKey{
        case blogs = "blogs"
        case recentBlogs = "recentBlogs"
        case blogCategories = "blogCategories"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        blogs = try? (values.decodeIfPresent(Blog.self,forKey: .blogs))
        recentBlogs = try? (values.decodeIfPresent([GetweddTipsNews].self,forKey: .recentBlogs))
        blogCategories = try? (values.decodeIfPresent([BlogDetailCategories].self,forKey: .blogCategories))
      //  vendorsInfo  = try? (values.decodeIfPresent(VendorInfo.self,forKey: .vendorsInfo))
    }
}
struct Blog: Codable {
    var data : [GetweddTipsNews]?

    enum codingKeys: String, CodingKey{
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        data = try? (values.decodeIfPresent([GetweddTipsNews].self,forKey: .data))
       
    }
}
