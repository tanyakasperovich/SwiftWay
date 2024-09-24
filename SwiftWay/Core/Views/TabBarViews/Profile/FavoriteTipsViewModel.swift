//
//  FavoriteTipsViewModel.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 22.12.23.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class FavoriteTipsViewModel: ObservableObject {
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var userFavoriteTips: [UserFavoriteTip] = []

    func getFavoriteTips() {
        Task {
            isLoading = true

            guard let authDataResult = try? AuthenticationManager.shared.getAuthenticatedUser() else {
                print("User not authenticated")
                return
            }
            self.userFavoriteTips = try await UserManager.shared.getAllUserFavoriteTips(userId: authDataResult.uid)

            isLoading = false
        }
    }

    func removeFromFavorites(favoriteTipId: String) {
        Task {
            guard let authDataResult = try? AuthenticationManager.shared.getAuthenticatedUser() else {
                print("User not authenticated")
                return
            }
            try? await UserManager.shared.removeUserFavoriteTip(userId: authDataResult.uid, favoriteTipId: favoriteTipId)
            getFavoriteTips()
        }
    }

}
