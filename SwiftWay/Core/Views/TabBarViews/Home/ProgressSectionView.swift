//
//  ProgressSectionView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 29.11.23.
//

import SwiftUI

// MARK: - Progress View...
struct ProgressSectionView: View {
    @Binding var showAddEducationTaskView: Bool
    @Binding var showAddWorkTaskView: Bool
    //@State var showSection: Bool = true
    @AppStorage("isShowingSectionProgress") var isShowingSectionProgress: Bool = true
    var selectedProfession: Profession
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                isShowingSectionProgress.toggle()
            } label: {
                HStack(alignment: .bottom) {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .foregroundStyle(Color.theme.fontColor.opacity(0.7))
                        .bold()
                        .padding(.trailing, 5)
                    
                    HeaderText(text: ("Progress").uppercased(), color: .theme.fontColorBW.opacity(0.7))
                                      
                    Spacer()
                    
                    Image(systemName: isShowingSectionProgress ? "chevron.down" : "chevron.right")
                        .bold()
                        .foregroundStyle(Color.theme.fontColorBW)
                        .opacity(0.7)
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
            }
            
            if isShowingSectionProgress {
                HStack(alignment: .top) {
                    // Задачи по обучению и по проекту......
                    VStack(alignment: .leading) {
                        // Задачи по обучению....
                        EducationTaskCardView(showAddEducationTaskView: $showAddEducationTaskView)
                        
                        // Задачи по проекту....
                        WorkTaskCardView(showAddWorkTaskView: $showAddWorkTaskView)
                    }
                    
                    // Общий прогресс по уровням...
                    LevelsProgress_CardView()
                }
                // .padding(.bottom, 5)
            }
            
        }
       // .padding(.top, 10)
    }
}

#Preview {
    ProgressSectionView(showAddEducationTaskView: .constant(false), showAddWorkTaskView: .constant(false), selectedProfession: Profession(title: "Title", sectorId: "", color: "Lime", image: "swift"))
        .environmentObject(RoadMapViewModel())
}


// MARK: - Education Task...
struct EducationTaskCardView: View {
    @State private var showEducationTaskProgressView: Bool = false
    @Binding var showAddEducationTaskView: Bool
    var dayTaskProgress = 10
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Задачи по обучению")
                .font(.body)
                .bold()
                .padding(.horizontal)
                .foregroundStyle(Color.theme.fontColorBW)
            
            if dayTaskProgress > 0 {
                Button {
                    showEducationTaskProgressView = true
                } label: {
                    CardView(content:
                          HStack {
                            ZStack {
                                                                 Circle()
                                                                     .frame(height: 25)
                                                                     .foregroundColor(.theme.darkPinkColor)
                                                                     .opacity(0.5)
                             
                                                                 Circle()
                                                                     .frame(height: 15)
                                                                     .foregroundColor(.white)
                                                                     .opacity(0.7)
                                                             }
                             
                            Text("\(dayTaskProgress) %")
                                .font(.body)
                                .bold()
                                .padding(.horizontal, 5)
                                .foregroundStyle(Color.theme.fontColorBW)
                                .opacity(0.9)
                                .lineLimit(1)
                             }
                        .padding(.vertical)
                             , color: .accentColor)
                    
                }
            } else {
                Button {
                    showAddEducationTaskView = true
                } label: {
                    CardView(content: 
                                CirclePrimaryButton(imageName: "plus", backgroundColor: .theme.darkPinkColor, imageColor: .white)
                             
                             //   PBView(content: Image(systemName: "plus").padding(5), color: .theme.darkPinkColor, isSet: .constant(true))
                             , color: .accentColor)
                }
            }
            
        }
        .sheet(isPresented: $showEducationTaskProgressView, content: {
            EducationTaskView()
                .presentationDetents([.large, .large])
                .presentationDragIndicator(.visible)
        })
    }
}

struct EducationTaskView: View {
    var body: some View {
        VStack {
            Text("Education Task")
            
        }
    }
}

// MARK: - Work Task...
struct WorkTaskCardView: View {
    @State private var showWorkTaskProgressView: Bool = false
    @Binding var showAddWorkTaskView: Bool
    var monthTaskProgress = 0
    
    var body: some View {
        VStack(alignment: .leading) {
                Text("Задачи по проекту")
                    .font(.body)
                    .bold()
                    .padding(.horizontal)
                    .foregroundStyle(Color.theme.fontColorBW)
                //.opacity(0.7)
            
            if monthTaskProgress > 0 {
                Button {
                    showWorkTaskProgressView = true
                } label: {
                    CardView(content:
                          HStack {
                            ZStack {
                                                                 Circle()
                                                                     .frame(height: 25)
                                                                     .foregroundColor(.theme.iceColor)
                                                                     .opacity(0.5)
                             
                                                                 Circle()
                                                                     .frame(height: 15)
                                                                     .foregroundColor(.white)
                                                                     .opacity(0.7)
                                                             }
                             
                            Text("\(monthTaskProgress) %")
                                .font(.body)
                                .bold()
                                .padding(.horizontal, 5)
                                .foregroundStyle(Color.theme.fontColorBW)
                                .opacity(0.9)
                                .lineLimit(1)
                             }
                        .padding(.vertical)
                             , color: .accentColor)
                }
                
            } else {
                Button {
                    showAddWorkTaskView = true
                } label: {
                    CardView(content: 
                              //  PBView(content: Image(systemName: "plus").padding(5), color: .theme.iceColor, isSet: .constant(true))
                      
                                CirclePrimaryButton(imageName: "plus", backgroundColor: .theme.iceColor, imageColor: .white)
                             , color: .accentColor)
                }
            }
            
        }
        .sheet(isPresented: $showWorkTaskProgressView, content: {
            WorkTaskView()
                .presentationDetents([.large, .large])
                .presentationDragIndicator(.visible)
        })
    }
}

struct WorkTaskView: View {
    
    var body: some View {
        VStack {
            Text("Work Task")
        }
    }
}


// MARK: - LevelsProgressView...
struct LevelsProgress_CardView: View {
    @EnvironmentObject var roadMapViewModel: RoadMapViewModel
    @State private var showLevelsProgressView: Bool = false
    
    var body: some View {
        VStack {
            Text("Общий прогресс")
                .font(.body)
                .bold()
                .padding(.horizontal)
                .foregroundStyle(Color.theme.fontColorBW)
            
            Button {
                showLevelsProgressView = true
            } label: {
                CardView(content:
                            VStack {
                    if roadMapViewModel.isLoadingLevels {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                            //.scaleEffect(2)
                    } else {
                        if roadMapViewModel.levels.isEmpty {
                            SubHeaderText(text: "No Item", color: .secondary)
                        } else {
                            VStack(alignment: .leading) {
                                ForEach(roadMapViewModel.levels) {level in
                                    Text(level.title ?? "")
                                        .foregroundStyle(Color.black)
                                        .opacity(0.8)
                                }
                                Spacer()
                            }
                        }
                    }
                }
                         , color: .accentColor)
            }
    
        }
        .sheet(isPresented: $showLevelsProgressView, content: {
            LevelsProgressView()
                .presentationDetents([.large, .large])
                .presentationDragIndicator(.visible)
        })
    }
}

struct LevelsProgressView: View {
    
    var body: some View {
        Text("Levels Progress View")
    }
}
