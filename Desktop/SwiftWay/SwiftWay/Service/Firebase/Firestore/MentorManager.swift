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
    
    private func mentorDocument(userId: String) -> DocumentReference {
        mentorCollection.document(userId)
    }
    
    func createNewMentor(user: DBUser) async throws {
        try mentorDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    func getMentor(userId: String) async throws -> Mentor {
        try await mentorDocument(userId: userId).getDocument(as: Mentor.self)
    }
    
//    func updateUserPremiumStatus(userId: String, isPremium: Bool) async throws {
//        let data: [String:Any] = [
//            DBUser.CodingKeys.isPremium.rawValue : isPremium,
//        ]
//
//        try await userDocument(userId: userId).updateData(data)
//    }
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        //        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        //        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    
//    // MARK: - Favorite tips....
//    private func userFavoriteTipCollection(userId: String) -> CollectionReference {
//        userDocument(userId: userId).collection("favorite_tips")
//    }
//
//    private func userFavoriteTipDocument(userId: String, favoriteTipId: String) -> DocumentReference {
//        userFavoriteTipCollection(userId: userId).document(favoriteTipId)
//    }
//
//    //  private var userFavoriteTipsListener: ListenerRegistration? = nil
//
//    func addUserFavoriteTip(userId: String, tipId: String) async throws {
//        let document = userFavoriteTipCollection(userId: userId).document()
//        let documentId = document.documentID
//
//        let data: [String:Any] = [
//            UserFavoriteTip.CodingKeys.id.rawValue : documentId,
//            UserFavoriteTip.CodingKeys.tipId.rawValue : tipId,
//            UserFavoriteTip.CodingKeys.dateCreated.rawValue : Timestamp()
//        ]
//
//        try await document.setData(data, merge: false)
//    }
//
//    func removeUserFavoriteTip(userId: String, favoriteTipId: String) async throws {
//        try await userFavoriteTipDocument(userId: userId, favoriteTipId: favoriteTipId).delete()
//    }
//
//    func getAllUserFavoriteTips(userId: String) async throws -> [UserFavoriteTip] {
//        try await userFavoriteTipCollection(userId: userId).getDocuments(as: UserFavoriteTip.self)
//    }
//
//    //    func removeListenerForAllUserFavoriteTips() {
//    //        self.userFavoriteTipsListener?.remove()
//    //    }
//    //
//    //    func addListenerForAllUserFavoriteTips1(userId: String, completion: @escaping (_ tips: [UserFavoriteTip]) -> Void) {
//    //        self.userFavoriteTipsListener = userFavoriteTipCollection(userId: userId).addSnapshotListener { querySnapshot, error in
//    //            guard let documents = querySnapshot?.documents else {
//    //                print("No documents")
//    //                return
//    //            }
//    //
//    //            let tips: [UserFavoriteTip] = documents.compactMap(
//    //                {try? $0.data(as: UserFavoriteTip.self) }
//    //            )
//    //            completion(tips)
//    //
//    //
//    //            querySnapshot?.documentChanges.forEach { diff in
//    //                if (diff.type == .added) {
//    //                    print("New tips: \(diff.document.data())")
//    //                }
//    //                if (diff.type == .modified) {
//    //                    print("Modified tips: \(diff.document.data())")
//    //                }
//    //                if (diff.type == .removed) {
//    //                    print("Removed tips: \(diff.document.data())")
//    //                }
//    //            }
//    //        }
//    //
//    //    }
//    //
//    //    func addListenerForAllUserFavoriteTips(userId: String) -> AnyPublisher<[UserFavoriteTip], Error> {
//    //        let (publisher, listener) = userFavoriteTipCollection(userId: userId)
//    //            .addSnapshotListener(as: UserFavoriteTip.self)
//    //
//    //        self.userFavoriteTipsListener = listener
//    //        return publisher
//    //    }
    
//    // MARK: - User Notes...
//    private func userNotesCollection(userId: String) -> CollectionReference {
//        userDocument(userId: userId).collection("user_notes")
//    }
//
//    private func userNoteDocument(userId: String, noteId: String) -> DocumentReference {
//        userNotesCollection(userId: userId).document(noteId)
//    }
//
//    func addUserNote(userId: String, note: UserNote) async throws {
//        let document = userNoteDocument(userId: userId, noteId: note.id)
//
//        try document.setData(from: note, merge: false)
//    }
//
//    func removeUserNote(userId: String, noteId: String) async throws {
//        try await userNoteDocument(userId: userId, noteId: noteId).delete()
//    }
//
//    func getAllUserNotes(userId: String) async throws -> [UserNote] {
//        try await userNotesCollection(userId: userId).getDocuments(as: UserNote.self)
//    }

//    // MARK: - User Tasks............
//    private func userTasksCollection(userId: String) -> CollectionReference {
//        userDocument(userId: userId).collection("user_tasks")
//    }
//
//    private func userTaskDocument(userId: String, taskId: String) -> DocumentReference {
//        userTasksCollection(userId: userId).document(taskId)
//    }
//
//    func addUserTask(userId: String, task: UserTask) async throws {
//        let document = userTaskDocument(userId: userId, taskId: task.id)
//
//        try document.setData(from: task, merge: false)
//    }
//
//    func removeUserTask(userId: String, taskId: String) async throws {
//        try await userTaskDocument(userId: userId, taskId: taskId).delete()
//    }
//
//    func updateUserTask(userId: String, taskId: String) async throws {
//       // try await userTaskDocument(userId: userId, taskId: taskId).delete()
//    }
//
//    func getAllUserTasks(userId: String) async throws -> [ UserTask] {
//
//       try await userTasksCollection(userId: userId).getDocuments(as: UserTask.self)
//
//    }
    
//    // MARK: - User Progress.........
//    private func userProgressCollection(userId: String) -> CollectionReference {
//        userDocument(userId: userId).collection("user_progress")
//    }
//
//    private func userProgressDocument(userId: String, progressId: String) -> DocumentReference {
//        userProgressCollection(userId: userId).document(progressId)
//    }
//
//    func addUserProgress(userId: String, progress: UserProgress) async throws {
//        let document = userProgressDocument(userId: userId, progressId: progress.id)
//
//        try document.setData(from: progress, merge: false)
//    }
//
//    func removeUserProgress(userId: String, progressId: String) async throws {
//        try await userProgressDocument(userId: userId, progressId: progressId).delete()
//    }
//    func getAllUserProgress(userId: String) async throws -> [ UserProgress] {
//
//       try await userProgressCollection(userId: userId).getDocuments(as: UserProgress.self)
//
//    }
//
//    func updateUserProgress(userId: String, progressId: String, quizScore: Int) async throws {
//        let data: [String:Any] = [
//            UserProgress.CodingKeys.quizScore.rawValue : quizScore
//        ]
//        try await userProgressDocument(userId: userId, progressId: progressId).updateData(data)
//    }
//
//    func getProgress(userId: String, progressId: String) async throws -> UserProgress {
//        try await userProgressDocument(userId: userId, progressId: progressId).getDocument(as: UserProgress.self)
//    }
    
}
