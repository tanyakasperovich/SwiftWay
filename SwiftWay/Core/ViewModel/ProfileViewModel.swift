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
        guard let authDataResult = try? AuthenticationManager.shared.getAuthenticatedUser() else {
            print("User not authenticated")
            return
        }
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

    func updateUserSelectedProfession(selectedProfession: String) {
        guard let user else { return }

        Task {
            try await UserManager.shared.updateUserSelectedProfession(userId: user.userId, selectedProfession: selectedProfession)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }

    //    // User Notes ...
    func addUserNote(note: UserNote) {
        Task {
            guard let authDataResult = try? AuthenticationManager.shared.getAuthenticatedUser() else {
                print("User not authenticated")
                return
            }
            try? await UserManager.shared.addUserNote(userId: authDataResult.uid, note: note)
        }
    }

    // User Tasks ...
    func addUserTask(task: UserTask) {
        Task {
            guard let authDataResult = try? AuthenticationManager.shared.getAuthenticatedUser() else {
                print("User not authenticated")
                return
            }
            try? await UserManager.shared.addUserTask(userId: authDataResult.uid, task: task)
        }
    }
}
