//
//  BlogDetailModel.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 08/04/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
struct BlogDetailModel: Codable {
    var blogCategories : [BlogDetailCategories]?
    var blog : BlogDetail?
    var recentBlogs : [BlogDetail]?
    var relatedBolgs : [BlogDetail]?
    var comments : [CommentDetail]?
    enum codingKeys: String, CodingKey{
        case blogCategories = "blogCategories"
       case blog = "blog"
        case recentBlogs = "recentBlogs"
        case relatedBolgs = "relatedBolgs"
        case comments = "comments"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        blogCategories = try? (values.decodeIfPresent([BlogDetailCategories].self,forKey: .blogCategories))
        blog = try? (values.decodeIfPresent(BlogDetail.self,forKey: .blog))
        recentBlogs = try? (values.decodeIfPresent([BlogDetail].self,forKey: .recentBlogs))
        relatedBolgs = try? (values.decodeIfPresent([BlogDetail].self,forKey: .relatedBolgs))
        comments = try? (values.decodeIfPresent([CommentDetail].self,forKey: .comments))
    }
}
struct BlogDetailCategories: Codable {
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

struct BlogDetail: Codable {
    var id : Int?
    var title : String?
    var description : String?
    var short_description : String?
    var author : String?
    var created_at : String?
    var total_comments : Int?
    var cover_image : String?
    enum codingKeys: String, CodingKey{
        case id = "id"
        case title = "title"
       case description = "description"
        case short_description = "short_description"
        case author = "author"
        case created_at = "created_at"
        case total_comments = "total_comments"
        case cover_image = "cover_image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        title = try? (values.decodeIfPresent(String.self,forKey: .title))
        description = try? (values.decodeIfPresent(String.self,forKey: .description))
        short_description = try? (values.decodeIfPresent(String.self,forKey: .short_description))
        author = try? (values.decodeIfPresent(String.self,forKey: .author))
        created_at = try? (values.decodeIfPresent(String.self,forKey: .created_at))
        total_comments = try? (values.decodeIfPresent(Int.self,forKey: .total_comments))
        cover_image = try? (values.decodeIfPresent(String.self,forKey: .cover_image))
    }
}
struct CommentDetail: Codable {
    var id : Int?
    var comment : String?
    var created_at : String?
    var getuser : LoggedUserInfo?
    var getcommentsreply : String?

    enum codingKeys: String, CodingKey{
        case id = "id"
        case comment = "comment"
       case created_at = "created_at"
        case getuser = "getuser"
        case getcommentsreply = "getcommentsreply"

    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        comment = try? (values.decodeIfPresent(String.self,forKey: .comment))
        created_at = try? (values.decodeIfPresent(String.self,forKey: .created_at))
        getuser = try? (values.decodeIfPresent(LoggedUserInfo.self,forKey: .getuser))
        getcommentsreply = try? (values.decodeIfPresent(String.self,forKey: .getcommentsreply))

    }
}
