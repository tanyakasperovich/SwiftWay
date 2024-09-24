//
//  MyProgressView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

struct RoadMap: View {
    @State private var selectedView = true
    @EnvironmentObject var roadMapViewModel: RoadMapViewModel

    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if selectedView {
                        RoadMapView()
                    } else {
                        LevelListView()
                    }
                }
                .offset(y: 65)
                .padding(.bottom, 65)
            }
            .background(BackgroundView(color: .accentColor, image: roadMapViewModel.selectedProfession?.image ?? ""))
            
            VStack {
                CustomPickerView(selectedView: $selectedView)
                Spacer()
            }
        }
        .navigationTitle(selectedView ? "Road Map" : "My Progress")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading:
                NavigationLink(
                    destination: HistoryQuizResultView(), // История прохождения..list....
                    label: {
                        ZStack {
                            RoundedRectangleShape(color: .accentColor)
                                .shadow(color: Color.black, radius: 2, x: 0, y: 2)
                            Image(systemName: "list.bullet.rectangle.fill")
                                .foregroundColor(.white).opacity(0.95)
                                .padding(.horizontal)
                                .padding(.vertical,5)
                        }
                    }),
            trailing:
                NavigationLink(
                    destination: CalendarView(), // Продолжить незавершенный тест.....
                    label: {
                        ZStack {
                            RoundedRectangleShape(color: .accentColor)
                                .shadow(color: Color.black, radius: 2, x: 0, y: 2)
                            Image(systemName: "play.rectangle.fill")
                                .foregroundColor(.white).opacity(0.95)
                                .padding(.horizontal)
                                .padding(.vertical,5)
                        }
                    })
        )
    }
}

#Preview {
    RoadMap()
        .environmentObject(RoadMapViewModel())
        .environmentObject(ProfileViewModel())
}


struct HistoryQuizResultView: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if profileViewModel.isLoading {
                ProgressView()
            } else {
           //     if let user = profileViewModel.user {
//                    List(user.progress ?? []) { progress in
//                        
//                        VStack {
//                            
//                            Text(progress.id)
//                            Text("Score: \(progress.quizScore)")
//                                .bold()
//                        }
//                        
//                    }
 //               }
            }
        }
    }
}
