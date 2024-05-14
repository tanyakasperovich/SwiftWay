//
//  UserTaskModel.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 30.04.24.
//

import Foundation

// User Task Model...
struct UserTask: Identifiable, Codable {
    var id = UUID().uuidString
    var title: String?
    var time: Date = Date()
    var disclosureExpanded: Bool?
    var description: String?
    var dateCreated: Date?
    var educationTask: Bool?
    var items: [Item]
    let professionId: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case time = "time"
        case disclosureExpanded = "disclosureExpanded"
        case description = "description"
        case dateCreated = "dateCreated"
        case educationTask = "educationTask"
        case items = "items"
        case professionId = "professionId"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.time = try container.decode(Date.self, forKey: .time)
        self.disclosureExpanded = try container.decode(Bool.self, forKey: .disclosureExpanded)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.educationTask = try container.decodeIfPresent(Bool.self, forKey: .educationTask)
        self.items = try container.decodeIfPresent([Item].self, forKey: .items) ?? []
        self.professionId = try container.decodeIfPresent(String.self, forKey: .professionId)

    }
    
    init(title: String, time: Date, disclosureExpanded: Bool, description: String, dateCreated: Date, educationTask: Bool, items: [Item], professionId: String) {
        self.title = title
        self.time = time
        self.disclosureExpanded = disclosureExpanded
        self.description = description
        self.dateCreated = dateCreated
        self.educationTask = educationTask
        self.items = items
        self.professionId = professionId
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.time, forKey: .time)
        try container.encodeIfPresent(self.disclosureExpanded, forKey: .disclosureExpanded)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.educationTask, forKey: .educationTask)
        try container.encodeIfPresent(self.items, forKey: .items)
        try container.encodeIfPresent(self.professionId, forKey: .professionId)
    }
    
}

struct Item: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> Item {
        return Item(id: id, title: title, isCompleted: !isCompleted)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case isCompleted = "isCompleted"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.isCompleted, forKey: .isCompleted)
    }
    
}
