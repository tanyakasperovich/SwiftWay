//
//  HomeView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI
// MARK: - Picker View...
struct HomeView: View {
    @State private var showAddEducationTaskView: Bool = false
    @State private var showAddWorkTaskView: Bool = false
    @EnvironmentObject var roadMapViewModel: RoadMapViewModel
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @State var selectedEducationTask: Bool = true
    @State var selectedWorkTask: Bool = false
    
    var body: some View {
        VStack {
            
            if let user = profileViewModel.user {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    HeaderView(showAddEducationTaskView: $showAddEducationTaskView, showAddWorkTaskView: $showAddWorkTaskView)
                                .padding(.horizontal, 5)
                                .padding(.bottom, 5)
                    
                    if let selectedProfession = user.selectedProfession {
//                        Text(selectedProfession)
//                        Text(roadMapViewModel.selectedProfession?.title ?? "")
                        VStack(alignment: .leading, spacing: 15) {
                            ProgressSectionView(showAddEducationTaskView: $showAddEducationTaskView, showAddWorkTaskView: $showAddWorkTaskView, selectedProfession: roadMapViewModel.selectedProfession ?? Profession(title: "", sectorId: "", color: "", image: ""))
                                .padding(.horizontal, 5)
                            
                            RoadMapSectionView()
                                .padding(.horizontal, 5)
                            
                            MentorsSectionView()
                            
                            TopsSectionView(selectedProfessionId: roadMapViewModel.selectedProfession?.id ?? "")
                                .padding(.horizontal, 5)
                            
                            TipCardView()
                                .padding(.horizontal, 5)
                        }
                    } else {
                        VStack {
                            Text("Select Profession")
                                .padding()
                                .foregroundStyle(Color.secondary)
                            
                            Spacer()
                        }
                    }
                   
                }
                } else {
                    ProgressView()
                }
        }
        .background(BackgroundView(color: Color(roadMapViewModel.selectedProfession?.color ?? "Lime"), image: roadMapViewModel.selectedProfession?.image ?? ""))
        .sheet(isPresented: $showAddEducationTaskView, content: {
           // AddEducationTaskView(showAddEducationTaskView: $showAddEducationTaskView)
            AddTaskView(selectedView: $selectedEducationTask, showAddTaskView: $showAddEducationTaskView)
                .presentationDetents([.large, .large])
                .presentationDragIndicator(.visible)
        })
        .sheet(isPresented: $showAddWorkTaskView, content: {
          //  AddWorkTaskView(showAddWorkTaskView: $showAddWorkTaskView)
            AddTaskView(selectedView: $selectedWorkTask, showAddTaskView: $showAddWorkTaskView)
                .presentationDetents([.large, .large])
                .presentationDragIndicator(.visible)
        })
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(RoadMapViewModel())
    }
}
