//
//  NotesViewModel.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 2.01.24.
//

import Foundation
import SwiftUI

@MainActor
final class NotesViewModel: ObservableObject {
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var userNotes: [UserNote] = []
 
    func getUserNotes() {
        Task {
        isLoading = true
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            self.userNotes = try await UserManager.shared.getAllUserNotes(userId: authDataResult.uid)
         isLoading = false
        }
    }
    
    func removeUserNote(noteId: String) {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            try? await UserManager.shared.removeUserNote(userId: authDataResult.uid, noteId: noteId)
             getUserNotes()
        }
    }
    
    func updateUserNote(noteId: String) {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            try? await UserManager.shared.updateUserNote(userId: authDataResult.uid, noteId: noteId, noteTitle: "noteTitle", noteDescription: "noteDescription", noteURL: "noteURL")
            getUserNotes()
        }
    }
}
