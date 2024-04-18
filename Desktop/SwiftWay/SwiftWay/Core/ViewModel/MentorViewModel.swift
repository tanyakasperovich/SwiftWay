//
//  MentorViewModel.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 1.04.24.
//

import SwiftUI

class MentorViewModel: ObservableObject {
    @Published var mentors: [Mentor] = [
        Mentor(userId: "", name: "Name", image: "swift", speciality: ["IOS Developer"], price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description")]),
        Mentor(userId: "", name: "Name", image: "swift", speciality: ["IOS Developer"], price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description")]),
        Mentor(userId: "", name: "Name", image: "swift", speciality: ["IOS Developer", "Product Designer"], price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description")]),
        Mentor(userId: "", name: "Name", image: "swift", speciality: ["Product Designer"], price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description")]),
        Mentor(userId: "", name: "Name", image: "", speciality: ["Product Designer", "UI/UX Designer"], price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description")]),
        Mentor(userId: "", name: "Name", image: "", speciality: ["UI/UX Designer"], price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description")])
    ]
    
}
