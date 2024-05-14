//
//  MentorViewModel.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 1.04.24.
//

import SwiftUI

class MentorViewModel: ObservableObject {
    @Published var mentors: [Mentor] = [
        Mentor(userId: "LkirwY1iFXbouIaS6Vkf2UszSyn1", name: "Name", image: "swift", professionId: [""], price: 10.0, rating: 0.0, reviews: [ReviewModel(userId: "1", review: "review review review. review. reviewreview reviewreview.", date: Date()), ReviewModel(userId: "2", review: "review review, reviewreview review reviewreview", date: Date())], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description")]),
        Mentor(userId: "", name: "Name", image: "swift", professionId: [""], price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description")]),
        Mentor(userId: "", name: "Name", image: "swift", professionId: ["", ""], price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description")]),
        Mentor(userId: "", name: "Name", image: "swift", professionId:  ["", ""], price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description")]),
        Mentor(userId: "", name: "Name", image: "", professionId: ["", ""], price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description")]),
        Mentor(userId: "", name: "Name", image: "", professionId:  ["", ""], price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description")])
    ]
//    @Published var mentors: [Mentor] = [
//        Mentor(userId: "", name: "Name", image: "swift", professions: [Profession(title: "IOS Developer", sectorTitle: "IT", color: "SectorIT")], price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description")]),
//        Mentor(userId: "", name: "Name", image: "swift", professions: [Profession(title: "IOS Developer", sectorTitle: "IT", color: "SectorIT")], price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description")]),
//        Mentor(userId: "", name: "Name", image: "swift", professions: [Profession(title: "IOS Developer", sectorTitle: "IT", color: "SectorIT"), Profession(title: "Product Designer", sectorTitle: "IT", color: "SectorIT")], price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description")]),
//        Mentor(userId: "", name: "Name", image: "swift", professions: [Profession(title: "Product Designer", sectorTitle: "IT", color: "SectorIT")], price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description")]),
//        Mentor(userId: "", name: "Name", image: "", professions: [Profession(title: "Product Designer", sectorTitle: "IT", color: "SectorIT"), Profession(title: "UI/UX Designer", sectorTitle: "IT", color: "SectorIT")], price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description")]),
//        Mentor(userId: "", name: "Name", image: "", professions: [Profession(title: "UI/UX Designer", sectorTitle: "IT", color: "SectorIT")], price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description")])
//    ]
    
}
