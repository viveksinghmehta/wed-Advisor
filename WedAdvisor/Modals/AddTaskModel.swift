//
//  AddTaskModel.swift
//  WedAdvisor
//
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
struct AddToDoModel: Codable {
    var status : Int?
    var data : ToDoListDataModel?

    enum codingKeys: String, CodingKey{
        case status = "status"
       case data = "data"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        status = try? (values.decodeIfPresent(Int.self,forKey: .status))
        data = try? (values.decodeIfPresent(ToDoListDataModel.self,forKey: .data))
    }
}
