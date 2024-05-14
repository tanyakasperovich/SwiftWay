//
//  MentorModel.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 1.04.24.
//

import SwiftUI

// MARK: - Mentor Model...
struct Mentor: Identifiable, Codable {
    var id = UUID().uuidString
    let userId: String?
    let name: String?
    let image: String?
    let professionId: String?
    let price: Double?
    let rating: Double?
    let reviews: [ReviewModel]
    let linkedInLink: String?
    let instagramLink: String?
    let youTubeLink: String?
    let link: String?
    let description: String?
    let students: [String]
    let skills: [SkillModel]
    
    init(userId: String, name: String, image: String, professionId: String?, price: Double, rating: Double, reviews: [ReviewModel], linkedInLink: String?, instagramLink: String?, youTubeLink: String?, link: String, description: String, students: [String], skills: [SkillModel]) {
        self.userId = userId
        self.name = name
        self.image = image
        self.professionId = professionId
        self.price = price
        self.rating = rating
        self.reviews = reviews
        self.linkedInLink = linkedInLink
        self.instagramLink = instagramLink
        self.youTubeLink = youTubeLink
        self.link = link
        self.description = description
        self.students = students
        self.skills = skills
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "userId"
        case name = "name"
        case image = "image"
        case professionId = "professionId"
        case price = "price"
        case rating = "rating"
        case reviews = "reviews"
        case linkedInLink = "linkedInLink"
        case instagramLink = "instagramLink"
        case youTubeLink = "youTubeLink"
        case link = "link"
        case description = "description"
        case students = "students"
        case skills = "skills"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.userId = try container.decodeIfPresent(String.self, forKey: .userId)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.professionId = try container.decodeIfPresent(String.self, forKey: .professionId)
        self.price = try container.decodeIfPresent(Double.self, forKey: .price)
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating)
        self.reviews = try container.decodeIfPresent([ReviewModel].self, forKey: .reviews) ?? []
        self.linkedInLink = try container.decodeIfPresent(String.self, forKey: .linkedInLink)
        self.instagramLink = try container.decodeIfPresent(String.self, forKey: .instagramLink)
        self.youTubeLink = try container.decodeIfPresent(String.self, forKey: .youTubeLink)
        self.link = try container.decodeIfPresent(String.self, forKey: .link)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.students = try container.decodeIfPresent([String].self, forKey: .students) ?? []
        self.skills = try container.decodeIfPresent([SkillModel].self, forKey: .skills) ?? []
    }
   
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.image, forKey: .image)
        try container.encodeIfPresent(self.professionId, forKey: .professionId)
        try container.encodeIfPresent(self.price, forKey: .price)
        try container.encodeIfPresent(self.rating, forKey: .rating)
        try container.encodeIfPresent(self.reviews, forKey: .reviews)
        try container.encodeIfPresent(self.linkedInLink, forKey: .linkedInLink)
        try container.encodeIfPresent(self.instagramLink, forKey: .instagramLink)
        try container.encodeIfPresent(self.youTubeLink, forKey: .youTubeLink)
        try container.encodeIfPresent(self.link, forKey: .link)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.students, forKey: .students)
        try container.encodeIfPresent(self.skills, forKey: .skills)
    }
}

// MARK: - Review about Mentor - Model...
struct ReviewModel: Identifiable, Codable {
    var id = UUID().uuidString
    let userId: String
    let review: String
    let date: Date
}

// MARK: - Mentor Skill Model...
    struct SkillModel: Identifiable, Codable {
    var id = UUID().uuidString
    let title: String
    let description: String
    let price: Int
}
