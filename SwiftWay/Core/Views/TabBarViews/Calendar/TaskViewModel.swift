//
//  TaskViewModel.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.01.24.
//

import Foundation
import SwiftUI

@MainActor
final class TaskViewModel: ObservableObject {
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var userTasks: [UserTask] = []

    func getUserTasks() async {
        do {
            isLoading = true
            guard let authDataResult = try? AuthenticationManager.shared.getAuthenticatedUser() else {
                print("User not authenticated")
                return
            }
            self.userTasks = try await UserManager.shared.getAllUserTasks(userId: authDataResult.uid)
        } catch {
            print("Failed to get tasks: \(error)")
            // Показать алерт пользователю
        }
        isLoading = false
    }

    func removeUserTask(taskId: String) {
        Task {
            guard let authDataResult = try? AuthenticationManager.shared.getAuthenticatedUser() else {
                print("User not authenticated")
                return
            }
            try? await UserManager.shared.removeUserTask(userId: authDataResult.uid, taskId: taskId)
            await getUserTasks()
        }
    }

    func updateUserTask(taskId: String) {
        Task {
            guard let authDataResult = try? AuthenticationManager.shared.getAuthenticatedUser() else {
                print("User not authenticated")
                return
            }
            try? await UserManager.shared.updateUserTask(userId: authDataResult.uid, taskId: taskId)
            await getUserTasks()
        }
    }
}

