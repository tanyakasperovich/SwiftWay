//
//  TabBarView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 19.10.23.
//

import SwiftUI

struct TabBarView: View {
    @Binding var showSignInView: Bool
    @State var selectedView: TabBar = .home
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var roadMapViewModel: RoadMapViewModel
    
    var body: some View {
        TabView(selection: $selectedView) {
            // MARK: - Home...
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label(TabBar.home.rawValue, systemImage: TabBar.home.image)
            }
            .tag(TabBar.home)
            
            // MARK: - Calendar...
            NavigationStack {
                CalendarView()
             //   TasksListView()
            }
            .tabItem {
                Label(TabBar.calendar.rawValue, systemImage: TabBar.calendar.image)
            }
            .tag(TabBar.calendar)
            
            // MARK: - MyProgress...
            NavigationStack {
                 MyProgressView()
            }
            .tabItem {
                Label(TabBar.myProgress.rawValue, systemImage: TabBar.myProgress.image)
            }
            .tag(TabBar.myProgress)
            
            // MARK: - Notes...
            NavigationStack {
               NotesView()
            }
            .tabItem {
                Label(TabBar.notes.rawValue, systemImage: TabBar.notes.image)
            }
            .tag(TabBar.notes)
            
            // MARK: - Settings...
            NavigationStack {
                ProfileView(showSignInView: $showSignInView)           
            }
            .tabItem {
                Label(TabBar.settings.rawValue, systemImage: TabBar.settings.image)
            }
            .tag(TabBar.settings)
        }
        .task {
            try? await profileViewModel.loadCurrentUser()
                
        // try? await roadMapViewModel.uploadSectors()
      
            
//            try? await roadMapViewModel.uploadRoadMapLevels()
            
//            switch roadMapViewModel.selectedProfession {
//            case .iosDeveloper:
//                try? await roadMapViewModel.getLevels()
//            case .productDesigner:
//                try? await roadMapViewModel.getTipOfTheDay()
//            case .uIUXDesigner:
//                try? await roadMapViewModel.getTipOfTheDay()
//            }
      
            // try? await roadMapViewModel.getLevels()
         //   try? await roadMapViewModel.getTipOfTheDay()
        }
    }
}

#Preview {
    TabBarView(showSignInView: .constant(false))
        .environmentObject(RoadMapViewModel())
        .environmentObject(ProfileViewModel())
}

enum TabBar: String {
    case home = "Home"
    case calendar = "Calendar"
    case myProgress = "My Progress"
    case notes = "My Notes"
    case settings = "Settings"
    
    var image: String {
        switch self {
        case .home:
            return "swift"
        case .calendar:
            return "calendar"
        case .myProgress:
            return "chart.line.uptrend.xyaxis"
        case .notes:
            return "book.pages"
        case .settings:
            return "gear"
        }
    }
}
