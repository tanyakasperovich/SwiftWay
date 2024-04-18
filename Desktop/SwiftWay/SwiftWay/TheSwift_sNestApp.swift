//
//  SwiftWayApp.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 21.03.23.
//

import SwiftUI
import Firebase

@main
struct SwiftWayApp: App {
    @AppStorage("isShowingOnboarding") var isShowingOnboarding: Bool = true
    // Data...
    @StateObject private var roadMapViewModel = RoadMapViewModel()
    // User...
    @StateObject private var userProfileViewModel = ProfileViewModel()
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            if isShowingOnboarding {
             OnboardingView()
            } else {
               ContentView()
                    .environmentObject(roadMapViewModel)
                    .environmentObject(userProfileViewModel)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
