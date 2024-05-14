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
   // @Published private(set) var tips: [(userFavoriteTips: UserFavoriteTip, tip: Tip)] = []
  //  private var cancellables = Set<AnyCancellable>()

//    func addListenerForFavorites() {
//        guard let authDataResult = try? AuthenticationManager.shared.getAuthenticatedUser() else { return }
//        
//        UserManager.shared.addListenerForAllUserFavoriteTips1(userId: authDataResult.uid) { [weak self] tips in
//            self?.userFavoriteTips = tips
//        }
//        
////        UserManager.shared.addListenerForAllUserFavoriteTips(userId: authDataResult.uid)
////            .sink { completion in
////
////            } receiveValue: { [weak self] tips in
////                self?.userFavoriteTips = tips
////            }
////            .store(in: &cancellables)
//        
//    }
    
    func getFavoriteTips() {
        Task {
            isLoading = true
            
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            self.userFavoriteTips = try await UserManager.shared.getAllUserFavoriteTips(userId: authDataResult.uid)
            
            isLoading = false
        }
        
        
//        Task {
//            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
////           let userFavoritedTips = try await UserManager.shared.getAllUserFavoriteTips(userId: authDataResult.uid)
////            
////            var localArray: [(userFavoriteTip: UserFavoriteTip, tip: Tip)] = []
////            for userFavoritedTip in userFavoritedTips {
////                if let tip = try? await RoadMapManager.shared.getTip(tipId: String(userFavoritedTip.tipId)) {
////                    localArray.append((userFavoritedTip, tip))
////                }
////            }
////            self.tips = localArray
//        }
    }
    
//    func getFavoriteTips() {
//        Task {
//            isLoading = true
//            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
//            let userFavoriteTips = try await UserManager.shared.getAllUserFavoriteTips(userId: authDataResult.uid)
//            
//            var localArray: [(userFavoriteTips: UserFavoriteTip, tip: Tip)] = []
//            for userFavoriteTip in userFavoriteTips {
//                if let tip = try? await RoadMapManager.shared.getTip(tipId: userFavoriteTip.tipId) {
//                    localArray.append((userFavoriteTip, tip))
//                }
//            }
//            
//            self.tips = localArray
//            isLoading = false
//        }
//    }
    
    func removeFromFavorites(favoriteTipId: String) {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            try? await UserManager.shared.removeUserFavoriteTip(userId: authDataResult.uid, favoriteTipId: favoriteTipId)
           getFavoriteTips()
        }
    }
    
}


