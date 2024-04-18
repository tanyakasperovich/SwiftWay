//
//  RoadMapView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

// MARK: - RoadMap View...
struct RoadMapView: View {
   // @State var selectedLevel: Levels = .level_1
    @State var selectedLevel: String = "Level 1"
    @State var selectedCategory: String = ""
    @State var color: Color = Color.accentColor
    @EnvironmentObject var roadMapViewModel: RoadMapViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if roadMapViewModel.isLoadingLevels {
                ProgressView()
            } else {
                //  Levels ...
                CardView(
                    content:
                        VStack {
                            if roadMapViewModel.isLoadingLevels {
                                ProgressView()
                            } else {
                                if roadMapViewModel.levels.isEmpty {
                                    SubHeaderText(text: "No Item", color: .secondary)
                                } else {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(roadMapViewModel.levels) { level in
                                                Button {
                                                    withAnimation {
                                                        //  selectedLevel = level.level
                                                        selectedLevel = level.title ?? ""
                                                    }
                                                } label: {
                                                    VStack {
                                                        PBView(content: Text(level.title ?? "").padding(.vertical, 12).padding(.horizontal), color: .pink, isSet: .constant(selectedLevel == level.title))
                                                        
                                                        ButtonView(content:
                                                                    VStack {
                                                            Text(level.title ?? "")
                                                                .bold()
                                                                .foregroundStyle((selectedLevel == level.title) ? Color.white : Color.secondary)
                                                                .padding(.vertical, 12)
                                                                .padding(.horizontal)
                                                            
                                                        },
                                                                   backgroundColor: (selectedLevel == level.title) ? .pink : .pink.opacity(0.5))
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        ,
                    color: .accentColor)
                .padding(5)
                
                // Categories...
                ForEach(roadMapViewModel.levels) {
                    if selectedLevel == $0.title {
                        CategoriesView(level: $0, selectedLevel: $selectedLevel, selectedCategory: $selectedCategory, color: $color)
                            .transition(.slide)
                    }
                }
            }
        }
    }
}

#Preview {
    RoadMapView()
        .environmentObject(RoadMapViewModel())
}

// MARK: - Categories View...
struct CategoriesView: View {
    var level: Level
    @Binding var selectedLevel: String
    @Binding var selectedCategory: String
    @Binding var color: Color
    
    var body: some View {
        // Categories...
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(level.categories ?? []) { category in
                    Button {
                        // Updating Category...
                        withAnimation{
                            color = Color(category.color ?? "")
                            selectedCategory = category.title ?? ""
                        }
                    } label: {
                        CategoryCardView(category: category, selectedCategory: $selectedCategory)
                            .padding(.vertical, 2)
                    }
                }
            }
            .padding(.leading)
        }
        
        
        // SubCategories...
        if selectedCategory != "" {
            VStack {
                ForEach(level.categories ?? []) { category in
                    
                    if selectedCategory == category.title {
                        SubCategoryView(category: category)
                            .padding(.horizontal)
                            .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    }
                }
            }
        }
        
    }
}

struct CategoryCardView: View {
    var category: Category
    @Binding var selectedCategory: String
    
    var body: some View {
        ZStack {
            RoundedRectangleShape(color: .theme.fontColorWB)
                .opacity(0.7)
                .frame(height: 55)
                .shadow(color: Color(category.color ?? ""), radius: 1, x: 2, y: 1)
            
            RoundedRectangleShape(color: Color(category.color ?? ""))
                .opacity(category.title == selectedCategory ? 1 : 0.2)
                .frame(height: 55)
            
            Text(category.title ?? "")
                .bold()
                .padding()
                .foregroundColor(selectedCategory == category.title ? .white : Color(category.color ?? ""))
                .opacity(selectedCategory == category.title ? 1 : 0.9)
        }
    }
}


// MARK: - SubCategory View...
struct SubCategoryView: View {
    var category: Category
    
    var body: some View {
        if (category.subCategory?.isEmpty ?? false) {
            VStack {
                Text("No Item...")
                    .foregroundStyle(.secondary)
            }
            .padding()
        } else {
            VStack {
            // Staggered Grid...
            StaggeredGrid(columns: 3, spacing: 15, list: category.subCategory ?? []) {item in
                
                // Card View...
                NavigationLink{
                    DetailSubCategoryView(color: Color(category.color ?? ""), subCategory: item)
                } label: {
                    ZStack {
                        RoundedRectangleShape(color: .white)
                            .shadow(color: Color(category.color ?? ""), radius: 1, x: 2, y: 1)
                        
                        RoundedRectangleShape(color: Color(category.color ?? ""))
                            .opacity(item.rating ?? 0.0 > 0 ? 1 : 0.2)
                        
                        VStack {
                            HStack {
                                if item.rating ?? 0.0 > 0 {
                                    Spacer()
                                    Image(systemName: item.rating == 100 ? "circle.hexagonpath.fill" : "circle.hexagonpath")
                                        .foregroundColor(.yellow)
                                        .opacity(item.rating == 100 ? 1 : 0.7)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            
                            Text(item.title ?? "")
                                .foregroundColor(item.rating ?? 0.0 > 0  ? .white : .secondary)
                                .padding(.horizontal)
                                .padding(.bottom)
                                .opacity(item.rating ?? 0.0 > 0 ? 1 : 0.7)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .background(
            RoundedRectangleShape(color: .accentColor)
                .shadow(color: .black, radius: 2, x: 1, y: 0))
       }
    }
}
