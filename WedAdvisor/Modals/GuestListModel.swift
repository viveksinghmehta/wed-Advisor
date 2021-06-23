//
//  GuestListModel.swift
//  WedAdvisor
//
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
struct GuestListModel: Codable {
    var allguest : GuestListModelDetail?
    var completedguest : GuestListModelDetail?
    var waitingguest : GuestListModelDetail?
    var declineguest : GuestListModelDetail?
    
    enum codingKeys: String, CodingKey{
       case allguest = "allguest"
        case completedguest = "completedguest"
        case waitingguest = "waitingguest"
        case declineguest = "declineguest"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        allguest = try? (values.decodeIfPresent(GuestListModelDetail.self,forKey: .allguest))
        completedguest = try? (values.decodeIfPresent(GuestListModelDetail.self,forKey: .completedguest))
        waitingguest = try? (values.decodeIfPresent(GuestListModelDetail.self,forKey: .waitingguest))
        declineguest = try? (values.decodeIfPresent(GuestListModelDetail.self,forKey: .declineguest))
    }
}

struct GuestListModelDetail: Codable {
    var all : Int?
    var single : Int?
    var couple : Int?
    var household : Int?
    
    enum codingKeys: String, CodingKey{
       case all = "all"
        case single = "single"
        case couple = "couple"
        case household = "household"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        all = try? (values.decodeIfPresent(Int.self,forKey: .all))
        single = try? (values.decodeIfPresent(Int.self,forKey: .single))
        couple = try? (values.decodeIfPresent(Int.self,forKey: .couple))
        household = try? (values.decodeIfPresent(Int.self,forKey: .household))
    }
}
