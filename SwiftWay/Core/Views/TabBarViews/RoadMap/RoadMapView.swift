//
//  RoadMapView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

struct RoadMapView: View {
   // @State var selectedLevel: Levels = .level_1
    @State var selectedLevel: String = "Level 1"
    @State var selectedCategory: String = ""
    @State var color: Color = Color.accentColor
    @EnvironmentObject var roadMapViewModel: RoadMapViewModel

    var body: some View {
      VStack {
            if roadMapViewModel.isLoadingLevels {
                ProgressView()
                    .padding()
            } else {
                if roadMapViewModel.levels.isEmpty {
                    SubHeaderText(text: "No Item", color: .secondary)
                        .padding()
                } else {
                    let sortedLevels = roadMapViewModel.levels.sorted(by: { $0.level ?? 0 < $1.level ?? 0})
                //  Levels ...
                    LevelList(sortedLevels: sortedLevels, selectedLevel: $selectedLevel)
                
                // Categories...
                ForEach(sortedLevels) {
                    if selectedLevel == $0.title {
                        CategoryList(level: $0, selectedLevel: $selectedLevel, selectedCategory: $selectedCategory, color: $color)
                            .transition(.slide)
                    }
                }
                            }
                }
        }
      .padding(.top, 10)
    }
}

// MARK: - Level...
struct LevelList: View {
    var sortedLevels: [Level]
    @Binding var selectedLevel: String
    
    var body: some View {
        CardView(
            content:
                VStack {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(sortedLevels) { level in
                                        Button {
                                            withAnimation {
                                                //  selectedLevel = level.level
                                                selectedLevel = level.title ?? ""
                                            }
                                        } label: {
                                                PBView(content: 
                                                        Text(level.title ?? "")
                                                    .padding(.vertical, 12)
                                                    .padding(.horizontal),
                                                       color: .pink,
                                                       isSet: .constant(selectedLevel == level.title))
                                        }
                                    }
                                }
                                .padding(.horizontal, 5)
                            }
                }
                .padding(.horizontal, -10)
                ,
            color: .accentColor)
        .padding(5)
    }
}
    
#Preview {
    RoadMapView()
        .environmentObject(RoadMapViewModel())
}

// MARK: - Category...
struct CategoryList: View {
    var level: Level
    @Binding var selectedLevel: String
    @Binding var selectedCategory: String
    @Binding var color: Color

    var body: some View {
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
                        CategoryCard(category: category, selectedCategory: selectedCategory)
                            .padding(.vertical, 2)
                    }
                }
            }
            .padding(.horizontal, 10)
        }

        if selectedCategory != "" {
            VStack {
                ForEach(level.categories ?? []) { category in
                    if selectedCategory == category.title {
                        CategoryDetail(category: category)
                            .padding()
                            .transition(.asymmetric(insertion: .scale, removal: .opacity))
                            .background(
                                    RoundedRectangleShape(color:  Color(category.color ?? ""))
                            )
                            .padding(.horizontal, 5)
                    }
                }
            }
        }
    }
}

struct CategoryCard: View {
    var category: Category
    var selectedCategory: String
    
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

struct CategoryDetail: View {
    var category: Category
    
    var body: some View {
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
                StaggeredGrid(columns: 3, spacing: 5, list: category.subCategory ?? []) {item in
                    
                    // Card View...
                    NavigationLink{
                        SubCategoryDetail(color: Color(category.color ?? ""), subCategory: item)
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
    }
}

//struct SubCategoryView: View {
//    var category: Category
//    
//    var body: some View {
//        if (category.subCategory?.isEmpty ?? false) {
//            VStack {
//                Text("No Item...")
//                    .foregroundStyle(.secondary)
//            }
//            .padding()
//        } else {
//          //  SubCategoriesListView(category: category)
//            VStack {
//            // Staggered Grid...
//            StaggeredGrid(columns: 3, spacing: 8, list: category.subCategory ?? []) {item in
//                
//                // Card View...
//                NavigationLink{
//                    SubCategoryView(color: Color(category.color ?? ""), subCategory: item)
//                } label: {
//                    PBView(content:                         
//                            VStack {
////                        HStack {
////                            if item.rating ?? 0.0 > 0 {
////                                Spacer()
////                                Image(systemName: item.rating == 100 ? "circle.hexagonpath.fill" : "circle.hexagonpath")
////                                    .foregroundColor(.yellow)
////                                    .opacity(item.rating == 100 ? 1 : 0.7)
////                            }
////                        }
////                        .padding(.horizontal)
////                        .padding(.vertical, 5)
//                        
//                        Text(item.title ?? "")
//                            .foregroundColor(item.rating ?? 0.0 > 0  ? .white : Color(category.color ?? "Lime"))
//                            .padding()
//                    },
//                           color: Color(category.color ?? "Lime"),
//                           isSet: (item.rating ?? 0.0) > 0 ? .constant(true) : .constant(false))
//                    
////                    ZStack {
////                        RoundedRectangleShape(color: .white)
////                            .shadow(color: Color(category.color ?? ""), radius: 1, x: 2, y: 1)
////                        
////                        RoundedRectangleShape(color: Color(category.color ?? ""))
////                            .opacity(item.rating ?? 0.0 > 0 ? 1 : 0.2)
////                        
////                        VStack {
////                            HStack {
////                                if item.rating ?? 0.0 > 0 {
////                                    Spacer()
////                                    Image(systemName: item.rating == 100 ? "circle.hexagonpath.fill" : "circle.hexagonpath")
////                                        .foregroundColor(.yellow)
////                                        .opacity(item.rating == 100 ? 1 : 0.7)
////                                }
////                            }
////                            .padding(.horizontal)
////                            .padding(.vertical, 5)
////                            
////                            Text(item.title ?? "")
////                                .foregroundColor(item.rating ?? 0.0 > 0  ? .white : .secondary)
////                                .padding(.horizontal)
////                                .padding(.bottom)
////                                .opacity(item.rating ?? 0.0 > 0 ? 1 : 0.7)
////                        }
////                    }
//                }
//            }
//            .padding(.horizontal)
//        }
//        .background(
//            RoundedRectangleShape(color: .accentColor)
//                .shadow(color: .black, radius: 2, x: 1, y: 0))
//       }
//    }
//}
