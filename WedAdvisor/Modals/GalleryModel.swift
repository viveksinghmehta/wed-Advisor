//
//  GalleryModel.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 31/03/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
import Foundation
struct galleryModel: Codable {
    var vendor_types : [HomeVendorType]?
   // var venues: [HomeVendorType]?
   var gallery : GalleryDetail?
    
    
    enum codingKeys: String, CodingKey{
        case vendor_types = "vendor_types"
       // case venues = "venues"
        case gallery = "gallery"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        vendor_types = try? (values.decodeIfPresent([HomeVendorType].self,forKey: .vendor_types))
       // venues = try? (values.decodeIfPresent([HomeVendorType].self,forKey: .venues))
        gallery  = try? (values.decodeIfPresent(GalleryDetail.self,forKey: .gallery))
    }
}


struct GalleryDetail: Codable {
    var data : [GalleryData]?
    var next_page_url : String?
    //var state : String?
    
    enum codingKeys: String, CodingKey{
      //  case name = "name"
        case data = "data"
        case next_page_url = "next_page_url"
       
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        data = try? (values.decodeIfPresent([GalleryData].self,forKey: .data))
        next_page_url = try? (values.decodeIfPresent(String.self,forKey: .next_page_url))
       //id = try? (values.decodeIfPresent(Int.self,forKey: .id))
    }
}


struct GalleryData: Codable {
    var id : Int?
    var image : String?
    //var state : String?
    
    enum codingKeys: String, CodingKey{
      //  case name = "name"
        case image = "image"
        case id = "id"
       
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        image = try? (values.decodeIfPresent(String.self,forKey: .image))
       // state = try? (values.decodeIfPresent(String.self,forKey: .state))
       id = try? (values.decodeIfPresent(Int.self,forKey: .id))
    }
}
