//
//  UserNote.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 30.04.24.
//

import Foundation

// User Note Model...
struct UserNote: Identifiable, Hashable, Codable  {
    var id = UUID().uuidString
    let title: String?
    let description: String?
    let url: String?
    let dateCreated: Date?
    let professionId: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case url = "url"
        case dateCreated = "date_created"
        case professionId = "professionId"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.professionId = try container.decodeIfPresent(String.self, forKey: .professionId)
    }
    
    init(title: String, description: String, url: String, dateCreated: Date, professionId: String) {
        self.title = title
        self.description = description
        self.url = url
        self.dateCreated = dateCreated
        self.professionId = professionId
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.url, forKey: .url)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.professionId, forKey: .professionId)
    }
}
