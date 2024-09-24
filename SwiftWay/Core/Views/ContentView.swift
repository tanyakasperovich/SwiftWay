//
//  ContentView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 19.10.23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            if !showSignInView {
                TabBarView(showSignInView: $showSignInView)
            }
        }
        .onAppear {
            Task {
                let authUser = try? await AuthenticationManager.shared.getAuthenticatedUser()
                await MainActor.run {
                    self.showSignInView = authUser == nil
                }
            }
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(RoadMapViewModel())
        .environmentObject(ProfileViewModel())
}
