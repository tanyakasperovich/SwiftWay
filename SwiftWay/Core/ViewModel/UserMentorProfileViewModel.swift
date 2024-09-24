//
//  UserMentorProfileViewModel.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 27.05.24.
//

import Foundation

@MainActor
final class UserMentorProfileViewModel: ObservableObject {    
    @Published var userMentorProfiles: [Mentor] = []
    @Published var userMentorProfile: Mentor? = nil
    
    func getAllUserMentorProfiles() async throws {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            self.userMentorProfiles = try await UserManager.shared.getAllUserMentorProfiles(userId: authDataResult.uid)
        }
    }
    
    func getUserMentorProfile(mentorId: String) async throws {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            self.userMentorProfile = try await UserManager.shared.getUserMentorProfile(userId: authDataResult.uid, mentorId: mentorId)
        }
    }

    func addMentorProfile(mentor: Mentor)async throws {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            try? await UserManager.shared.addMentorProfile(userId: authDataResult.uid, mentor: mentor)
        }
    }
    
    func removeUserMentorProfile(mentorId: String) async throws {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            try? await UserManager.shared.removeMentorProfile(userId: authDataResult.uid, mentorId: mentorId)
        }
    }
        
    func updateUserMentorProfile(mentor: Mentor) async throws {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            try? await UserManager.shared.updateMentorProfile(userId: authDataResult.uid, mentorId: mentor.id, mentorName: mentor.name ?? "", mentorImage: mentor.image ?? "", price: mentor.price ?? 0.0, mentorLinkedInLink: mentor.linkedInLink ?? "", mentorInstagramLink: mentor.instagramLink ?? "", mentorYouTubeLink: mentor.youTubeLink ?? "", mentorLink: mentor.link ?? "", mentorDescription: mentor.description ?? "", mentorSkills: [])
        }
    }
}
