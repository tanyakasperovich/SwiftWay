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
 
    func getUserTasks() {
        Task {
        isLoading = true
            
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            self.userTasks = try await UserManager.shared.getAllUserTasks(userId: authDataResult.uid)
            
         isLoading = false
        }
    }
    
    func removeUserTask(taskId: String) {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            try? await UserManager.shared.removeUserTask(userId: authDataResult.uid, taskId: taskId)
            getUserTasks()
        }
    }
    
    func updateUserTask(taskId: String) {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            try? await UserManager.shared.updateUserTask(userId: authDataResult.uid, taskId: taskId)
            getUserTasks()
        }
    }
    
}

