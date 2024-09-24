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
                Label(TabBar.home.rawValue, systemImage: roadMapViewModel.selectedProfession?.image ?? TabBar.home.image)
            }
            .tag(TabBar.home)
            
            // MARK: - Calendar...
            NavigationStack {
                CalendarView()
            }
            .tabItem {
                Label(TabBar.calendar.rawValue, systemImage: TabBar.calendar.image)
            }
            .tag(TabBar.calendar)
            
            // MARK: - MyProgress...
            NavigationStack {
                RoadMap()
            }
            .tabItem {
                Label(TabBar.roadMap.rawValue, systemImage: TabBar.roadMap.image)
            }
            .tag(TabBar.roadMap)
            
            // MARK: - Notes...
            NavigationStack {
                NotesView(professionId: roadMapViewModel.selectedProfession?.id ?? "")
                    .environment(\.managedObjectContext, SwiftWayManager().context)
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
       //  try? await roadMapViewModel.uploadSectors()
       //     try? await roadMapViewModel.uploadRoadMapLevels()
        }
        .accentColor(Color(roadMapViewModel.selectedProfession?.color ?? "Lime"))
    }
}

#Preview {
    TabBarView(showSignInView: .constant(false))
        .environmentObject(RoadMapViewModel())
        .environmentObject(ProfileViewModel())
        .environment(\.managedObjectContext, SwiftWayManager().context)
}

enum TabBar: String {
    case home = "Home"
    case calendar = "Calendar"
    case roadMap = "RoadMap"
    case notes = "My Notes"
    case settings = "Profile"
    
    var image: String {
        switch self {
        case .home:
            return "house"
        case .calendar:
            return "calendar"
        case .roadMap:
            return "map"
           // return "chart.line.uptrend.xyaxis"
        case .notes:
            return "doc.plaintext"
            //return "book.pages"
        case .settings:
            return "person.fill"
        }
    }
}
