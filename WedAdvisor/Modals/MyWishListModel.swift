//
//  MyWishListModel.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 06/04/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
struct MywishListModel: Codable {
    var vendorsDetails : MywishListModelDetail?
 
    
    enum codingKeys: String, CodingKey{
        case vendorsDetails = "vendorsDetails"

      
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        vendorsDetails = try? (values.decodeIfPresent(MywishListModelDetail.self,forKey: .vendorsDetails))

    }
}


struct MywishListModelDetail: Codable {
    var data : [MywishListModelData]?

    enum codingKeys: String, CodingKey{
        case data = "data"
      
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        data = try? (values.decodeIfPresent([MywishListModelData].self,forKey: .data))


    }
}


struct MywishListModelData: Codable {
    
    var user_id : Int?
    var vendor_id: Int?
    var vendor: VedorDetailData?
    var vendorstype: [HomeVendor]?
    var location : [CityData]?
    
    enum codingKeys: String, CodingKey {
        case user_id = "user_id"
        case vendor_id = "vendor_id"
       case vendor = "vendor"
       case vendorstype = "vendorstype"
        case location = "location"
      
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        user_id = try? (values.decodeIfPresent(Int.self,forKey: .user_id))
        vendor_id = try? (values.decodeIfPresent(Int.self,forKey: .vendor_id))
       vendor = try? (values.decodeIfPresent(VedorDetailData.self,forKey: .vendor))
        vendorstype = try? (values.decodeIfPresent([HomeVendor].self,forKey: .vendorstype))
        location = try? (values.decodeIfPresent([CityData].self,forKey: .location))


    }
}
