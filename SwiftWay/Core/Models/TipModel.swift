//
//  TipModel.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 1.04.24.
//

import SwiftUI

// MARK: - Tip Model...
struct Tip: Identifiable, Codable {
    var id = UUID().uuidString
    let title: String?
    
    init(title: String) {
        self.title = title
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        
        try container.encodeIfPresent(self.title, forKey: .title)
    }
}
