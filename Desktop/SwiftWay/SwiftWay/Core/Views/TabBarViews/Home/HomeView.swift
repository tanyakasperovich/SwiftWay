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
    @State var selectedEducationTask: Bool = true
    @State var selectedWorkTask: Bool = false
    
    var body: some View {
        VStack {
            HeaderView(showAddEducationTaskView: $showAddEducationTaskView, showAddWorkTaskView: $showAddWorkTaskView, selectedProfession: $roadMapViewModel.selectedProfession)
                .padding(.horizontal, 5)
            
            ScrollView(.vertical, showsIndicators: true) {
                
                VStack(alignment: .leading) {
                    ProgressSectionView(showAddEducationTaskView: $showAddEducationTaskView, showAddWorkTaskView: $showAddWorkTaskView)
                        .padding(.horizontal, 8)
                    
                    // Divider()
                    
                    RoadMapCardView()
                        .padding(.horizontal, 8)
                    
                  //  Divider()
                    
                    MentorsSectionView()
                    
                    Divider()
                    
                    TopsSectionView()
                        .padding(.horizontal, 8)
                    
                   // Divider()
                    
                    TipCardView()
                        .padding(.horizontal, 8)
                }
                .foregroundColor(.accentColor)
            }
        }
        .background(BackgroundView(color: .accentColor))
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
