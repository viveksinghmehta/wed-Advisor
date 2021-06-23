//
//  GetDashBoard.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 06/04/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
struct dashboardModel: Codable {
    var wishlistVendors : Int?
    var allGuests: Int?
     var totaltask: Int?
     var completedtask: Int?
     var pendingtask: Int?
     var seatingtable: Int?
     var budgetsum: Int?
     var guestaccepted: Int?
     var guestdeclined: Int?
    
    enum codingKeys: String, CodingKey{
        case wishlistVendors = "wishlistVendors"
        case allGuests = "allGuests"
        case totaltask = "totaltask"
        case completedtask = "completedtask"
        case pendingtask = "pendingtask"
        case seatingtable = "seatingtable"
        case budgetsum = "budgetsum"
        case guestaccepted = "guestaccepted"
        case guestdeclined = "guestdeclined"
      
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        wishlistVendors = try? (values.decodeIfPresent(Int.self,forKey: .wishlistVendors))
        allGuests = try? (values.decodeIfPresent(Int.self,forKey: .allGuests))
        totaltask = try? (values.decodeIfPresent(Int.self,forKey: .totaltask))
        completedtask = try? (values.decodeIfPresent(Int.self,forKey: .completedtask))
        pendingtask = try? (values.decodeIfPresent(Int.self,forKey: .pendingtask))
        seatingtable = try? (values.decodeIfPresent(Int.self,forKey: .seatingtable))
        budgetsum = try? (values.decodeIfPresent(Int.self,forKey: .budgetsum))
        guestaccepted = try? (values.decodeIfPresent(Int.self,forKey: .guestaccepted))
        guestdeclined = try? (values.decodeIfPresent(Int.self,forKey: .guestdeclined))

    }
}
