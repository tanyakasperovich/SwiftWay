//
//  RoadMapCardView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 13.04.24.
//

import SwiftUI

// MARK: - RoadMap Card View...
struct RoadMapCardView: View {
    @EnvironmentObject var roadMapViewModel: RoadMapViewModel
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("ROAD MAP")
                .bold()
                .padding(.horizontal)
                .padding(.bottom, 5)
                .foregroundStyle(Color.theme.fontColorBW)
                .opacity(0.7)
            
                CardView(
                    content:
                        VStack(alignment: .leading) {
                                if roadMapViewModel.isLoadingLevels {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                                        //.scaleEffect(2)
                                } else {
                                    if roadMapViewModel.levels.isEmpty {
                                        SubHeaderText(text: "No Item", color: .secondary)
                                    } else {
                                        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                                            ForEach(roadMapViewModel.levels) { level in
                                                NavigationLink {
                                                    LevelRoadMapView(level: level)
                                                } label: {
                                                    ButtonView(
                                                        content:
                                                            VStack(alignment: .leading) {
                                                                Spacer()
                                                                Text(level.title ?? "")
                                                                    .font(.headline)
                                                                    .foregroundStyle(Color.white)
                                                                    .padding(.vertical, 2)
                                                                    .padding(.horizontal, 10)
                                                                Spacer()
                                                            },
                                                        backgroundColor: .pink)
                                                }
                                            }
                                        }
                                    }
                                }
                        }
                        .task {
                            try? await roadMapViewModel.getLevels()
                        }
                        ,
                    color: color)
        }
        .padding(.bottom, 10)
    }
}


#Preview {
    RoadMapCardView(color: Professions.iosDeveloper.accentColor)
        .environmentObject(RoadMapViewModel())
}

// MARK: -  View...
struct LevelRoadMapView: View {
    var level: Level
    
    var body: some View {
        ScrollView {
            ForEach(level.categories ?? []) { category in
                    
                    CategoryView(category: category)
                        .padding(.horizontal, 3)
                }
        }
        .navigationTitle(level.title ?? "")
        .background(BackgroundView(color: .accentColor))
    }
}

struct CategoryView: View {
    @State private var showCategory = false
    var category: Category
    
    var body: some View {
                DisclosureGroup(
                    isExpanded: $showCategory,
                    content: {
                       // SubCategoryView(category: category)
                        if (category.subCategory?.isEmpty ?? false) {
                            VStack {
                                Text(category.description ?? "")
                                    .foregroundStyle(Color.white.opacity(0.9))
                                    .font(.body)
                                
                                
                                Text("No Item...")
                                    .foregroundStyle(.secondary)
                                    .padding(.vertical)
                            }
                            .padding()
                        } else {
                            VStack(alignment: .leading) {
                                Text(category.description ?? "")
                                    .foregroundStyle(Color.white.opacity(0.9))
                                    .font(.body)
                                
                                // Staggered Grid...
                                StaggeredGrid(columns: 3, spacing: 15, list: category.subCategory ?? []) {item in
                                    
                                    // Card View...
                                    NavigationLink{
                                        DetailSubCategoryView(color: Color(category.color ?? ""), subCategory: item)
                                    } label: {
                                        ZStack {
                                            RoundedRectangleShape(color: .white)
                                            
                                            VStack {
                                                Text(item.title ?? "")
                                                    .foregroundColor( Color(category.color ?? ""))
                                                    .padding()
                                            }
                                        }
                                        }
                                }
                                
                                Text("Count: \(category.subCategory?.count ?? 0)")
                                    .foregroundStyle(Color.white.opacity(0.7))
                            }
                            .padding(.horizontal)
                        }
                    },
                    label: {
                        VStack {
                            Text(category.title ?? "")
                                .foregroundColor(.white)
                                .font(.title3)
                                .bold()
                                .padding()
                        }
                    }
                )
                .padding()
                .accentColor(.white)
                .bold()
                .background(
                        RoundedRectangleShape(color:  Color(category.color ?? ""))
                )
    }
}
