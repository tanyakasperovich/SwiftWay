//
//  RoadMapModel.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI
import Foundation

// MARK: - Sector Model...
struct Sector: Identifiable, Hashable, Codable {
    var id = UUID().uuidString
    let title: String?
    let professions: [Profession]?
    let color: String?
    
    init(title: String, professions: [Profession], color: String) {
        self.title = title
        self.professions = professions
        self.color = color
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case professions = "professions"
        case color = "color"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.professions = try container.decodeIfPresent([Profession].self, forKey: .professions)
        self.color = try container.decodeIfPresent(String.self, forKey: .color)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.professions, forKey: .professions)
        try container.encodeIfPresent(self.color, forKey: .color)
    }
}

// MARK: - Profession Model...
struct Profession: Identifiable, Hashable, Codable {
    var id = UUID().uuidString
    let title: String?
    let sectorTitle: String?
    let color: String?
    let image: String?
    
    init(title: String, sectorTitle: String, color: String, image: String) {
        self.title = title
        self.sectorTitle = sectorTitle
        self.color = color
        self.image = image
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case sectorTitle = "sectorTitle"
        case color = "color"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.sectorTitle = try container.decodeIfPresent(String.self, forKey: .sectorTitle)
        self.color = try container.decodeIfPresent(String.self, forKey: .color)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.sectorTitle, forKey: .sectorTitle)
        try container.encodeIfPresent(self.color, forKey: .color)
        try container.encodeIfPresent(self.image, forKey: .image)
    }
}

// MARK: - Level Model...
struct Level: Identifiable, Hashable, Codable {
    var id = UUID().uuidString
    let title: String?
    let rating: Double?
    let categories: [Category]?
    let level: Int?
    let professionId: String?
    
    init(title: String, rating: Double, categories: [Category], level: Int, professionId: String) {
      
        self.title = title
        self.rating = rating
        self.categories = categories
        self.level = level
        self.professionId = professionId
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case rating = "rating"
        case categories = "categories"
        case level = "level"
        case professionId = "professionId"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating)
        self.categories = try container.decodeIfPresent([Category].self, forKey: .categories)
        self.level = try container.decodeIfPresent(Int.self, forKey: .level)
        self.professionId = try container.decodeIfPresent(String.self, forKey: .professionId)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.rating, forKey: .rating)
        try container.encodeIfPresent(self.categories, forKey: .categories)
        try container.encodeIfPresent(self.level, forKey: .level)
        try container.encodeIfPresent(self.professionId, forKey: .professionId)
    }
}

struct Category: Identifiable, Hashable, Codable {
    var id = UUID().uuidString
    let title: String?
    let subTitle: String?
    let description: String?
    let color: String?
    let rating: Double?
    let subCategory: [SubCategory]?
    
    init(title: String, subTitle: String, description: String, color: String, rating: Double, subCategory: [SubCategory]) {
        self.title = title
        self.subTitle = subTitle
        self.description = description
        self.color = color
        self.rating = rating
        self.subCategory = subCategory
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case subTitle = "subTitle"
        case description = "description"
        case color = "color"
        case rating = "rating"
        case subCategory = "subCategory"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.subTitle = try container.decodeIfPresent(String.self, forKey: .subTitle)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.color = try container.decodeIfPresent(String.self, forKey: .color)
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating)
        self.subCategory = try container.decodeIfPresent([SubCategory].self, forKey: .subCategory)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.subTitle, forKey: .subTitle)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.color, forKey: .color)
        try container.encodeIfPresent(self.rating, forKey: .rating)
        try container.encodeIfPresent(self.subCategory, forKey: .subCategory)
    }
}

struct SubCategory: Identifiable, Hashable, Codable {
    var id = UUID().uuidString
    let title: String?
    let description: String?
    let url: String?
    let rating: Double?
    let isPremiumAccess: Bool?
    let tests: [Quiz]?
    
    init(title: String, description: String, url: String, rating: Double, isPremiumAccess: Bool, tests: [Quiz]) {
        self.title = title
        self.description = description
        self.url = url
        self.rating = rating
        self.isPremiumAccess = isPremiumAccess
        self.tests = tests
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case url = "url"
        case rating = "rating"
        case isPremiumAccess = "is_premium_access"
        case tests = "tests"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating)
        self.isPremiumAccess = try container.decodeIfPresent(Bool.self, forKey: .isPremiumAccess)
        self.tests = try container.decodeIfPresent([Quiz].self, forKey: .tests)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.url, forKey: .url)
        try container.encodeIfPresent(self.rating, forKey: .rating)
        try container.encodeIfPresent(self.isPremiumAccess, forKey: .isPremiumAccess)
        try container.encodeIfPresent(self.tests, forKey: .tests)
    }
}

// MARK: - Quiz Model...
struct Quiz: Identifiable, Hashable, Codable  {
    var id = UUID().uuidString
    let title: String?
    let description: String?
    let rating: Double?
    let questions: [Question]?
    
    init(title: String, description: String, rating: Double, questions: [Question]) {
      
        self.title = title
        self.description = description
        self.rating = rating
        self.questions = questions
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case rating = "rating"
        case questions = "questions"
        case quizResult = "quizResult"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating)
        self.questions = try container.decodeIfPresent([Question].self, forKey: .questions)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.rating, forKey: .rating)
        try container.encodeIfPresent(self.questions, forKey: .questions)
    }
}

struct Question: Identifiable, Hashable, Codable  {
    var id = UUID().uuidString
    let title: String?
    let description: String?
    let answers: [String]?
    let correctAnswer: String?
    let clue: Clue?
    
    init(title: String, description: String, answers: [String], correctAnswer: String, clue: Clue) {
      
        self.title = title
        self.description = description
        self.answers = answers
        self.correctAnswer = correctAnswer
        self.clue = clue
    }

    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case answers = "answers"
        case correctAnswer = "correctAnswer"
        case clue = "clue"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.answers = try container.decodeIfPresent([String].self, forKey: .answers)
        self.correctAnswer = try container.decodeIfPresent(String.self, forKey: .correctAnswer)
        self.clue = try container.decodeIfPresent(Clue.self, forKey: .clue)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.answers, forKey: .answers)
        try container.encodeIfPresent(self.correctAnswer, forKey: .correctAnswer)
        try container.encodeIfPresent(self.clue, forKey: .clue)
    }
    
}

struct Clue: Identifiable, Hashable, Codable  {
    var id = UUID().uuidString
    let title: String?
    let description: String?
    let url: String?
    
    init(title: String, description: String, url: String) {
      
        self.title = title
        self.description = description
        self.url = url
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.url, forKey: .url)
    }
}







// MARK: - Professions Enum...
enum Professions: String, CaseIterable {
    case iosDeveloper = "IOS Developer"
    case productDesigner = "Product Designer"
    case uIUXDesigner = "UI/UX Designer"
    
    case lashMaker = "Lash Maker"
    
    var description: String {
        switch self {
        case .iosDeveloper:
            return "IOS Developer"
        case .productDesigner:
            return "Product Designer"
        case .uIUXDesigner:
            return "UI/UX Designer"
        case .lashMaker:
            return "Lash Maker"
        }
    }
    
    var accentColor: Color {
        switch self {
        case .iosDeveloper, .productDesigner, .uIUXDesigner:
            return .theme.limeColor
        case .lashMaker:
            return .theme.purpleColor
        }
    }
    
    var sector: String {
        switch self {
        case .iosDeveloper, .productDesigner, .uIUXDesigner:
            return "IT"
        case .lashMaker:
            return "Beauty"
        }
    }
    
}

enum Sectors: String, CaseIterable {
    case iTSector = "IT"
    case beautySector = "Beauty"
    
    var professions: [Professions] {
        switch self {
        case .iTSector:
            return [.iosDeveloper, .productDesigner, .uIUXDesigner]
        case .beautySector:
            return [.lashMaker]
        }
    }
    
}
