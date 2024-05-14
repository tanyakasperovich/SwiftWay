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
    @Published var tip: Tip? = nil
    
    // Get Tips...
    func getTipOfTheDay() async throws {
        self.tips = try await TipManager.shared.getTips()
   }
    func getTip() async throws {
        try? await getTipOfTheDay()
        let randomTip = tips.shuffled().first ?? Tip(title: "")
        let randomTipId = randomTip.id
        self.tip = try await TipManager.shared.getTip(tipId: randomTipId)
   }
    
    func addUserFavoriteTip(tipId: String) {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            try? await UserManager.shared.addUserFavoriteTip(userId: authDataResult.uid, tipId: tipId)
        }
    }

}
