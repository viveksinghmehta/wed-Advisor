//
//  TodoModel.swift
//  WedAdvisor
//
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
struct ToDoModel: Codable {
    //var loggedUser : [BlogDetailCategories]?
    var todolist : ToDoListModel?
    var completedtask : Int?
    var duetask : Int?
    var pendingtask : Int?
    var alltask : Int?
    
    enum codingKeys: String, CodingKey{
        //      case loggedUser = "loggedUser"
       case todolist = "todolist"
        case completedtask = "completedtask"
        case duetask = "duetask"
        case pendingtask = "pendingtask"
        case alltask = "alltask"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
     //   loggedUser = try? (values.decodeIfPresent([BlogDetailCategories].self,forKey: .loggedUser))
        todolist = try? (values.decodeIfPresent(ToDoListModel.self,forKey: .todolist))
        completedtask = try? (values.decodeIfPresent(Int.self,forKey: .completedtask))
        duetask = try? (values.decodeIfPresent(Int.self,forKey: .duetask))
        pendingtask = try? (values.decodeIfPresent(Int.self,forKey: .pendingtask))
        alltask = try? (values.decodeIfPresent(Int.self,forKey: .alltask))
    }
}


struct ToDoListModel: Codable {
    var current_page : Int?
    var data : [ToDoListDataModel]?
    var next_page_url : String?
    enum codingKeys: String, CodingKey{
       case current_page = "current_page"
        case data = "data"
        case next_page_url = "next_page_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        current_page = try? (values.decodeIfPresent(Int.self,forKey: .current_page))
        data = try? (values.decodeIfPresent([ToDoListDataModel].self,forKey: .data))
        next_page_url = try? (values.decodeIfPresent(String.self,forKey: .next_page_url))
    }
}
struct ToDoListDataModel: Codable {
    var id : Int?
    var task_title : String?
    var created_at : String?
    var tasktype : BlogDetail?
    var task_date : String?
    enum codingKeys: String, CodingKey{
       case id = "id"
        case task_title = "task_title"
        case created_at = "created_at"
        case tasktype = "tasktype"
        case task_date = "task_date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try? (values.decodeIfPresent(Int.self,forKey: .id))
        task_title = try? (values.decodeIfPresent(String.self,forKey: .task_title))
        created_at = try? (values.decodeIfPresent(String.self,forKey: .created_at))
        tasktype = try? (values.decodeIfPresent(BlogDetail.self,forKey: .tasktype))
        task_date = try? (values.decodeIfPresent(String.self,forKey: .task_date))
    }
}
