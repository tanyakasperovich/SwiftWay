//
//  MentorViewModel.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 1.04.24.
//

import SwiftUI

@MainActor
final class MentorViewModel: ObservableObject {
    
    @Published var mentors: [Mentor] = [
        Mentor(userId: "", name: "Name", image: "1", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024", price: 10.0, rating: 0.0, reviews: [ReviewModel(userId: "1", review: "review review review. review. reviewreview reviewreview.", date: Date()), ReviewModel(userId: "2", review: "review review, reviewreview review reviewreview", date: Date())], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description", price: 0.0)]),
        Mentor(userId: "", name: "Name", image: "2", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024", price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description", price: 0.0)]),
        Mentor(userId: "", name: "Name", image: "3", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024", price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description", price: 0.0)]),
        Mentor(userId: "", name: "Name", image: "1", professionId: "165272FB-A37F-4D4E-B329-3E763730B079", price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description", price: 0.0)]),
        Mentor(userId: "", name: "Name", image: "2", professionId: "165272FB-A37F-4D4E-B329-3E763730B079", price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description", price: 0.0)]),
        Mentor(userId: "", name: "Name", image: "3", professionId: "165272FB-A37F-4D4E-B329-3E763730B079", price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description", price: 0.0)]),
        Mentor(userId: "", name: "Name", image: "1", professionId: "165272FB-A37F-4D4E-B329-3E763730B079", price: 10.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [ SkillModel(title: "Skill title", description: "Skill description", price: 0.0)])
    ]
    
    func getAllMentors() async throws {
        Task {
            self.mentors = try await MentorManager.shared.getAllMentors()
        }
    }
    
    func addMentorProfile(mentor: Mentor) async throws {
        Task {
            try? await MentorManager.shared.addMentor(mentor: mentor)
        }
    }
    
    func removeUserMentorProfile(mentorId: String) async throws {
        Task {
            try? await MentorManager.shared.removeMentor(mentorId: mentorId)
        }
    }
        
    func updateUserMentorProfile(mentor: Mentor) async throws {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            try? await MentorManager.shared.updateMentor(userId: authDataResult.uid, mentorId: mentor.id, mentorName: mentor.name ?? "", mentorImage: mentor.image ?? "", price: mentor.price ?? 0.0, mentorLinkedInLink: mentor.linkedInLink ?? "", mentorInstagramLink: mentor.instagramLink ?? "", mentorYouTubeLink: mentor.youTubeLink ?? "", mentorLink: mentor.link ?? "", mentorDescription: mentor.description ?? "", mentorSkills: [])
        }
    }
    
}
