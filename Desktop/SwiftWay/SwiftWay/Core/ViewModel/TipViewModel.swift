//
//  TipViewModel.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 1.04.24.
//

import Foundation

// MARK: - Tip View Model...
@MainActor
final class TipViewModel: ObservableObject {
    // Tips...
    @Published var tips: [Tip] = []
    @Published var isLoadingTips: Bool = false
    
    // Get Tips...
    func getTipOfTheDay() async throws {
        self.tips = try await TipManager.shared.getTips()

//        let tips = manager.getTipsOfTheDay()
//
//        isLoadingTips = true
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//            self.tips = tips
//            self.isLoadingTips = false
//        }
   }
    
    func addUserFavoriteTip(tipId: String) {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            try? await UserManager.shared.addUserFavoriteTip(userId: authDataResult.uid, tipId: tipId)
        }
    }

}
