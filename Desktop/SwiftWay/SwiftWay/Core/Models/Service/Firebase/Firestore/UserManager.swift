//
//  UserManager.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 14.11.23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

// Progress Model...

//struct UserProgress: Identifiable, Hashable, Codable {
////    var id = UUID().uuidString
////    let userId: String
////    let totalProgress: Int // update......
////    let levelsProgress: [LevelProgress]
////}
////
////struct LevelProgress: Identifiable, Hashable, Codable {
////    var id = UUID().uuidString
////    let levelId: String
////    let levelRating: Int // update......
////    let subCategoriesRating: [SubCategoryProgress]
////}
////
////struct CategoryProgress: Identifiable, Hashable, Codable {
////    var id = UUID().uuidString
////    let categoryId: String
////    let categoryRating: Int // update......
////    let subCategoriesRating: [SubCategoryProgress]
////}
////
////struct SubCategoryProgress: Identifiable, Hashable, Codable {
////    var id = UUID().uuidString
////    let subCategoryId: String
////    let subCategoryRating: Int // update......
////    let quizesProgress: [QuizPassing]
////}
//
//// struct QuizPassing: Identifiable, Hashable, Codable {
//    var id = UUID().uuidString
//    let quizId: String
//    let passingDate: Date
//    let status: String
//    let quizScore: Int
//}

enum QuizStatus: String {
    case red = "red"
    case yellow = "yellow"
    case green = "green"
}

//struct CategoryRating: Identifiable, Hashable, Codable {
//    var id = UUID().uuidString
//    let subCategoriesRating: [SubCategoryRating]
//    
//    var categoryRating: Int {
//        let rating = subCategoriesRating.reduce(0, { (result, element) in result + element}) / subCategoriesRating.count
//
//        return rating
//    }
//}

//struct SubCategoryRating: Identifiable, Hashable, Codable {
//    var id = UUID().uuidString
//    let quizScores: [Int]
//    
//    var subCategoryRating: Int {
//       let rating = quizScores.reduce(0, { (result, element) in result + element}) / quizScores.count
//        
//        return rating
//    }
//}

//struct QuizScore: Identifiable, Hashable, Codable {
//    var id = UUID().uuidString
//    let quizScore: Int
//}


// MARK: - DBUser Model...
struct DBUser: Codable {
    let userId: String
    let isAnonymous: Bool?
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
    let isPremium: Bool?
    let profileImagePath: String?
    let profileImagePathUrl: String?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.isAnonymous = auth.isAnonymous
        self.email = auth.email
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.isPremium = false
        self.profileImagePath = nil
        self.profileImagePathUrl = nil
    }
    
    init(
        userId: String,
        isAnonymous: Bool? = nil,
        email: String? = nil,
        photoUrl: String? = nil,
        dateCreated: Date? = nil,
        isPremium: Bool? = nil,
        profileImagePath: String? = nil,
        profileImagePathUrl: String? = nil
    ) {
        self.userId = userId
        self.isAnonymous = isAnonymous
        self.email = email
        self.photoUrl = photoUrl
        self.dateCreated = dateCreated
        self.isPremium = isPremium
        self.profileImagePath = profileImagePath
        self.profileImagePathUrl = profileImagePathUrl
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case isAnonymous = "is_anonymous"
        case email = "email"
        case photoUrl = "photo_url"
        case dateCreated = "date_created"
        case isPremium = "user_isPremium"
        case profileImagePath = "profile_image_path"
        case profileImagePathUrl = "profile_image_path_url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.isAnonymous = try container.decodeIfPresent(Bool.self, forKey: .isAnonymous)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.isPremium = try container.decodeIfPresent(Bool.self, forKey: .isPremium)
        self.profileImagePath = try container.decodeIfPresent(String.self, forKey: .profileImagePath)
        self.profileImagePathUrl = try container.decodeIfPresent(String.self, forKey: .profileImagePathUrl)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.isAnonymous, forKey: .isAnonymous)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.isPremium, forKey: .isPremium)
        try container.encodeIfPresent(self.profileImagePath, forKey: .profileImagePath)
        try container.encodeIfPresent(self.profileImagePathUrl, forKey: .profileImagePathUrl)
    }
}

// User Favorite Tip Model...
struct UserFavoriteTip: Codable {
    let id: String
    let tipId: String
    let dateCreated: Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.tipId = try container.decode(String.self, forKey: .tipId)
        self.dateCreated = try container.decode(Date.self, forKey: .dateCreated)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case tipId = "tip_id"
        case dateCreated = "date_created"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.tipId, forKey: .tipId)
        try container.encode(self.dateCreated, forKey: .dateCreated)
    }
}

// User Note Model...
struct UserNote: Identifiable, Hashable, Codable  {
    var id = UUID().uuidString
    let title: String?
    let description: String?
    let url: String?
    let dateCreated: Date?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case url = "url"
        case dateCreated = "date_created"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
    }
    
    init(title: String, description: String, url: String, dateCreated: Date) {
        self.title = title
        self.description = description
        self.url = url
        self.dateCreated = dateCreated
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.url, forKey: .url)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
    }
}

// User Task Model...
struct UserTask: Identifiable, Codable {
    var id = UUID().uuidString
    var title: String?
    var time: Date = Date()
    var disclosureExpanded: Bool?
    var description: String?
    var dateCreated: Date?
    var educationTask: Bool?
    var items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case time = "time"
        case disclosureExpanded = "disclosureExpanded"
        case description = "description"
        case dateCreated = "dateCreated"
        case educationTask = "educationTask"
        case items = "items"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.time = try container.decode(Date.self, forKey: .time)
        self.disclosureExpanded = try container.decode(Bool.self, forKey: .disclosureExpanded)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.educationTask = try container.decodeIfPresent(Bool.self, forKey: .educationTask)
        self.items = try container.decodeIfPresent([Item].self, forKey: .items) ?? []
    }
    
    init(title: String, time: Date, disclosureExpanded: Bool, description: String, dateCreated: Date, educationTask: Bool, items: [Item]) {
        self.title = title
        self.time = time
        self.disclosureExpanded = disclosureExpanded
        self.description = description
        self.dateCreated = dateCreated
        self.educationTask = educationTask
        self.items = items
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.time, forKey: .time)
        try container.encodeIfPresent(self.disclosureExpanded, forKey: .disclosureExpanded)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.educationTask, forKey: .educationTask)
        try container.encodeIfPresent(self.items, forKey: .items)

    }
    
}

struct Item: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> Item {
        return Item(id: id, title: title, isCompleted: !isCompleted)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case isCompleted = "isCompleted"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.isCompleted, forKey: .isCompleted)
    }
    
}

// User Progress Model...
struct UserProgress: Identifiable, Codable  {
    var id = UUID().uuidString
    let dateCreated: Date?
    let levelId: String
    let categoryId: String
    let subCategoryId: String
    let quizId: String
    let quizScore: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case dateCreated = "date_created"
        case levelId = "level_id"
        case categoryId = "category_id"
        case subCategoryId = "subCategory_id"
        case quizId = "quiz_id"
        case quizScore = "quiz_score"

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.dateCreated = try container.decode(Date.self, forKey: .dateCreated)
        self.levelId = try container.decode(String.self, forKey: .levelId)
        self.categoryId = try container.decode(String.self, forKey: .categoryId)
        self.subCategoryId = try container.decode(String.self, forKey: .subCategoryId)
        self.quizId = try container.decode(String.self, forKey: .quizId)
        self.quizScore = try container.decode(Int.self, forKey: .quizScore)
    }
    
    init(dateCreated: Date, levelId: String, categoryId: String, subCategoryId: String, quizId: String, quizScore: Int) {
        self.dateCreated = dateCreated
        self.levelId = levelId
        self.categoryId = categoryId
        self.subCategoryId = subCategoryId
        self.quizId = quizId
        self.quizScore = quizScore
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.id, forKey: .id)
        try container.encode(self.dateCreated, forKey: .dateCreated)
        try container.encode(self.levelId, forKey: .levelId)
        try container.encode(self.categoryId, forKey: .categoryId)
        try container.encode(self.subCategoryId, forKey: .subCategoryId)
        try container.encode(self.quizId, forKey: .quizId)
        try container.encode(self.quizScore, forKey: .quizScore)
    }
}

// MARK: - User Manager...
final class UserManager {
    
    static let shared = UserManager()
    private init() { }
    
    // MARK: - Users....
    private let userCollection: CollectionReference = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self)
    }
    
    func updateUserPremiumStatus(userId: String, isPremium: Bool) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.isPremium.rawValue : isPremium,
        ]
        
        try await userDocument(userId: userId).updateData(data)
    }
    
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
    
    
    // MARK: - Favorite tips....
    private func userFavoriteTipCollection(userId: String) -> CollectionReference {
        userDocument(userId: userId).collection("favorite_tips")
    }
    
    private func userFavoriteTipDocument(userId: String, favoriteTipId: String) -> DocumentReference {
        userFavoriteTipCollection(userId: userId).document(favoriteTipId)
    }
    
    //  private var userFavoriteTipsListener: ListenerRegistration? = nil
    
    func addUserFavoriteTip(userId: String, tipId: String) async throws {
        let document = userFavoriteTipCollection(userId: userId).document()
        let documentId = document.documentID
        
        let data: [String:Any] = [
            UserFavoriteTip.CodingKeys.id.rawValue : documentId,
            UserFavoriteTip.CodingKeys.tipId.rawValue : tipId,
            UserFavoriteTip.CodingKeys.dateCreated.rawValue : Timestamp()
        ]
        
        try await document.setData(data, merge: false)
    }
    
    func removeUserFavoriteTip(userId: String, favoriteTipId: String) async throws {
        try await userFavoriteTipDocument(userId: userId, favoriteTipId: favoriteTipId).delete()
    }
    
    func getAllUserFavoriteTips(userId: String) async throws -> [UserFavoriteTip] {
        try await userFavoriteTipCollection(userId: userId).getDocuments(as: UserFavoriteTip.self)
    }
    
    //    func removeListenerForAllUserFavoriteTips() {
    //        self.userFavoriteTipsListener?.remove()
    //    }
    //
    //    func addListenerForAllUserFavoriteTips1(userId: String, completion: @escaping (_ tips: [UserFavoriteTip]) -> Void) {
    //        self.userFavoriteTipsListener = userFavoriteTipCollection(userId: userId).addSnapshotListener { querySnapshot, error in
    //            guard let documents = querySnapshot?.documents else {
    //                print("No documents")
    //                return
    //            }
    //
    //            let tips: [UserFavoriteTip] = documents.compactMap(
    //                {try? $0.data(as: UserFavoriteTip.self) }
    //            )
    //            completion(tips)
    //
    //
    //            querySnapshot?.documentChanges.forEach { diff in
    //                if (diff.type == .added) {
    //                    print("New tips: \(diff.document.data())")
    //                }
    //                if (diff.type == .modified) {
    //                    print("Modified tips: \(diff.document.data())")
    //                }
    //                if (diff.type == .removed) {
    //                    print("Removed tips: \(diff.document.data())")
    //                }
    //            }
    //        }
    //
    //    }
    //
    //    func addListenerForAllUserFavoriteTips(userId: String) -> AnyPublisher<[UserFavoriteTip], Error> {
    //        let (publisher, listener) = userFavoriteTipCollection(userId: userId)
    //            .addSnapshotListener(as: UserFavoriteTip.self)
    //
    //        self.userFavoriteTipsListener = listener
    //        return publisher
    //    }
    
    // MARK: - User Notes...
    private func userNotesCollection(userId: String) -> CollectionReference {
        userDocument(userId: userId).collection("user_notes")
    }
    
    private func userNoteDocument(userId: String, noteId: String) -> DocumentReference {
        userNotesCollection(userId: userId).document(noteId)
    }
    
    func addUserNote(userId: String, note: UserNote) async throws {
        let document = userNoteDocument(userId: userId, noteId: note.id)
        
        try document.setData(from: note, merge: false)
    }
    
    func removeUserNote(userId: String, noteId: String) async throws {
        try await userNoteDocument(userId: userId, noteId: noteId).delete()
    }
    
    func getAllUserNotes(userId: String) async throws -> [UserNote] {
        try await userNotesCollection(userId: userId).getDocuments(as: UserNote.self)
    }

    // MARK: - User Tasks............
    private func userTasksCollection(userId: String) -> CollectionReference {
        userDocument(userId: userId).collection("user_tasks")
    }
    
    private func userTaskDocument(userId: String, taskId: String) -> DocumentReference {
        userTasksCollection(userId: userId).document(taskId)
    }
    
    func addUserTask(userId: String, task: UserTask) async throws {
        let document = userTaskDocument(userId: userId, taskId: task.id)
        
        try document.setData(from: task, merge: false)
    }
    
    func removeUserTask(userId: String, taskId: String) async throws {
        try await userTaskDocument(userId: userId, taskId: taskId).delete()
    }
    
    func updateUserTask(userId: String, taskId: String) async throws {
       // try await userTaskDocument(userId: userId, taskId: taskId).delete()
    }
    
    func getAllUserTasks(userId: String) async throws -> [ UserTask] {
        
       try await userTasksCollection(userId: userId).getDocuments(as: UserTask.self)
        
    }
    
    // MARK: - User Progress.........
    private func userProgressCollection(userId: String) -> CollectionReference {
        userDocument(userId: userId).collection("user_progress")
    }
    
    private func userProgressDocument(userId: String, progressId: String) -> DocumentReference {
        userProgressCollection(userId: userId).document(progressId)
    }
    
    func addUserProgress(userId: String, progress: UserProgress) async throws {
        let document = userProgressDocument(userId: userId, progressId: progress.id)
        
        try document.setData(from: progress, merge: false)
    }
    
    func removeUserProgress(userId: String, progressId: String) async throws {
        try await userProgressDocument(userId: userId, progressId: progressId).delete()
    }
    func getAllUserProgress(userId: String) async throws -> [ UserProgress] {
        
       try await userProgressCollection(userId: userId).getDocuments(as: UserProgress.self)
        
    }
    
    func updateUserProgress(userId: String, progressId: String, quizScore: Int) async throws {
        let data: [String:Any] = [
            UserProgress.CodingKeys.quizScore.rawValue : quizScore
        ]
        try await userProgressDocument(userId: userId, progressId: progressId).updateData(data)
    }
    
    func getProgress(userId: String, progressId: String) async throws -> UserProgress {
        try await userProgressDocument(userId: userId, progressId: progressId).getDocument(as: UserProgress.self)
    }
    
}
