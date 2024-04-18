//
//  ProfileViewModel.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 14.11.23.
//

import SwiftUI
import PhotosUI
import Combine

@MainActor
final class ProfileViewModel: ObservableObject {
    // DBUser...
        @Published private(set) var user: DBUser? = nil
        
        @Published private(set) var isLoading: Bool = false
        
        func loadCurrentUser() async throws {
            isLoading = true
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
            isLoading = false
        }

        func togglePremiumStatus() {
            guard let user else { return }
            let currentValue = user.isPremium ?? false
            Task {
                try await UserManager.shared.updateUserPremiumStatus(userId: user.userId, isPremium: !currentValue)
                self.user = try await UserManager.shared.getUser(userId: user.userId)
            }
        }
    
    // User Notes ...
    func addUserNote(note: UserNote) {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            try? await UserManager.shared.addUserNote(userId: authDataResult.uid, note: note)
        }
    }
    
    // User Tasks ...
    func addUserTask(task: UserTask) {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            try? await UserManager.shared.addUserTask(userId: authDataResult.uid, task: task)
        }
    }
    
    // User Progress ...
//    func addUserProgress(progress: UserProgress) {
//            guard let user else { return }
//          
//            Task {
//                try await UserManager.shared.addUserProgress(userId: user.userId, userProgress: progress)
//                self.user = try await UserManager.shared.getUser(userId: user.userId)
//            }
//        }
//    
//    func updateUserProgress(quizId: String, passingDate: Date, status: String, quizScore: Int) {
//        guard let user else { return }
//        let lastId = user.progress?.last?.id ?? ""
//        Task {
//            try await UserManager.shared.updateUserProgress(userId: user.userId, userProgress: UserProgress(id: lastId, quizId: quizId, passingDate: passingDate, status: status, quizScore: quizScore))
//            self.user = try await UserManager.shared.getUser(userId: user.userId)
//        }
//    }
//    
//    func removeUserProgress(progress: UserProgress) {
//            guard let user else { return }
//    
//        Task {
//                try await UserManager.shared.removeUserProgress(userId: user.userId, userProgress: progress)
//                self.user = try await UserManager.shared.getUser(userId: user.userId)
//            }
//        }
    
//    func addUserPreference(text: String) {
//        guard let user else { return }
//
//        Task {
//            try await UserManager.shared.addUserPreference(userId: user.userId, preference: text)
//            self.user = try await UserManager.shared.getUser(userId: user.userId)
//        }
//    }
//
//    func removeUserPreference(text: String) {
//        guard let user else { return }
//
//        Task {
//            try await UserManager.shared.removeUserPreference(userId: user.userId, preference: text)
//            self.user = try await UserManager.shared.getUser(userId: user.userId)
//        }
//    }
//

//    func saveProfileImage(item: PhotosPickerItem) {
//        guard let user else { return }
//
//        Task {
//            guard let data = try await item.loadTransferable(type: Data.self) else { return }
//            let (path, name) = try await StorageManager.shared.saveImage(data: data, userId: user.userId)
//            print("SUCCESS!")
//            print(path)
//            print(name)
//            let url = try await StorageManager.shared.getUrlForImage(path: path)
//            try await UserManager.shared.updateUserProfileImagePath(userId: user.userId, path: path, url: url.absoluteString)
//        }
//    }
//
//    func deleteProfileImage() {
//        guard let user, let path = user.profileImagePath else { return }
//        
//        Task {
//            try await StorageManager.shared.deleteImage(path: path)
//            try await UserManager.shared.updateUserProfileImagePath(userId: user.userId, path: nil, url: nil)
//        }
//    }
}

