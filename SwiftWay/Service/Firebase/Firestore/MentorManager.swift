//
//  MentorManager.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 13.04.24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

// MARK: - Mentor Manager...
final class MentorManager {
    
    static let shared = MentorManager()
    private init() { }
    
    // MARK: - Mentors....
    private let mentorCollection: CollectionReference = Firestore.firestore().collection("mentors")
    
    private func mentorDocument(mentorId: String) -> DocumentReference {
        mentorCollection.document(mentorId)
    }
    
    func addMentor(mentor: Mentor) async throws {
        let document = mentorDocument(mentorId: mentor.id)
        
        try document.setData(from: mentor, merge: false)
    }
    
    func updateMentor(userId: String, mentorId: String, mentorName: String, mentorImage: String, price: Double, mentorLinkedInLink: String, mentorInstagramLink: String, mentorYouTubeLink: String, mentorLink: String, mentorDescription: String, mentorSkills: [SkillModel]) async throws {
        let data: [String:Any] = [
            Mentor.CodingKeys.name.rawValue : mentorName,
            Mentor.CodingKeys.image.rawValue : mentorImage,
            Mentor.CodingKeys.price.rawValue : price,
            Mentor.CodingKeys.linkedInLink.rawValue : mentorLinkedInLink,
            Mentor.CodingKeys.instagramLink.rawValue : mentorInstagramLink,
            Mentor.CodingKeys.youTubeLink.rawValue : mentorYouTubeLink,
            Mentor.CodingKeys.link.rawValue : mentorLink,
            Mentor.CodingKeys.description.rawValue : mentorDescription,
            Mentor.CodingKeys.skills.rawValue : mentorSkills
        ]
        
        try await mentorDocument(mentorId: mentorId).updateData(data)
    }
    
    func removeMentor(mentorId: String) async throws {
        try await mentorDocument(mentorId: mentorId).delete()
    }
    
    func getMentor(mentorId: String) async throws -> Mentor {
        try await mentorDocument(mentorId: mentorId).getDocument(as: Mentor.self)
    }
    
    func getAllMentors() async throws -> [Mentor] {
        try await mentorCollection.getDocuments(as: Mentor.self)
    }
//    
//    private let encoder: Firestore.Encoder = {
//        let encoder = Firestore.Encoder()
//        //        encoder.keyEncodingStrategy = .convertToSnakeCase
//        return encoder
//    }()
//    
//    private let decoder: Firestore.Decoder = {
//        let decoder = Firestore.Decoder()
//        //        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        return decoder
//    }()

    
}
