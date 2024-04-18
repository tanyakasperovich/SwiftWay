//
//  LevelsView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

// MARK: - Levels View...
struct LevelListView: View {
    @State private var showLevel = false
    @EnvironmentObject var roadMapViewModel: RoadMapViewModel
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if roadMapViewModel.isLoadingLevels {
                ProgressView()
            } else {
                if roadMapViewModel.levels.isEmpty {
                    SubHeaderText(text: "No Item", color: .secondary)
                } else {
                    ForEach(roadMapViewModel.levels) { level in
                                            DisclosureGroup(
                                                isExpanded: $showLevel,
                                                content: {
                                                    CategoryListView(level: level)
                                                },
                                                label: {
                                                    LevelRowView(showLevel: $showLevel, level: level)
                                                })
                                            .bold()
                                            .background(RoundedRectangleShape(color: .accentColor)
                                                .shadow(color: Color.black, radius: 2, x: 2, y: -2))
                                            .padding(.top, 10)
                                            .padding(.horizontal,10)
                }
                }
           }
        }
    }
}

#Preview {
    LevelListView()
        .environmentObject(RoadMapViewModel())
        .environmentObject(ProfileViewModel())
}

struct LevelRowView: View {
    @Binding var showLevel: Bool
    var level: Level
    
    var body: some View {
        VStack {
            LinearProgressView(progress: ((level.rating ?? 0)/100), level: level)
                .padding()
            
        HStack {
            ZStack {
                RoundedRectangleShape(color: Color.theme.cardColor)
                    .shadow(color: Color.black, radius: 1, x: 0, y: 1)
                
                HStack{
                    Text(level.title ?? "")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(Color.accentColor)
                    Spacer()
                    //                                Text("\(filteredCategories.count) / \(level.categories.count)")
                    //                                    .foregroundColor(.secondary)
                }
                .padding()
                .opacity(0.9)
            }
            .padding(.leading)
            
            ZStack {
                RoundedRectangleShape(color: Color.theme.cardColor)
                    .frame(width: 55, height: 55)
                    .shadow(color: Color.black, radius: 1, x: 0, y: 1)
                
                Image(systemName: showLevel ? "chevron.down" : "chevron.right")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.accentColor)
            }
        }
        .padding(.bottom, 30)
    }
    }
}

// MARK: - Category View...
struct CategoryListView: View {
    @State private var showCategory = false
    var level: Level
    
    var body: some View {
        ForEach(level.categories ?? []) { category in
        DisclosureGroup(
            isExpanded: $showCategory,
            content: {
                SubCategoryListView(category: category)
            },
            label: {
                CategoryRowView(category: category)
            })
        .accentColor((category.rating ?? 0.0) > 0 ? .white : .secondary)
        .bold()
        .padding()
        .background(
            ZStack {
                RoundedRectangleShape(color: .white)
                    .opacity(0.7)
                    .shadow(color: Color(category.color ?? "Lime"), radius: 1, x: 2, y: 1)
                
                RoundedRectangleShape(color: Color(category.color ?? "Lime"))
                    .opacity((category.rating ?? 0.0) > 0 ? 1 : 0.2)
            }
        )
        .padding(.horizontal, 25)
    }
    Spacer(minLength: 25)
    }
}

struct SubCategoryListView: View {
    var category: Category

    var body: some View {
        ForEach(category.subCategory ?? [], id: \.self) { subCategory in
            NavigationLink {
                DetailSubCategoryView(color: Color(category.color ?? ""), subCategory: subCategory)
            } label: {
                SubCategoryRowView(subCategory: subCategory)
            }
                .padding(.vertical, 5)
                .padding(.horizontal)
        }
    }
}

struct CategoryRowView: View {
    var category: Category
    
    var body: some View {
        ZStack {
            HStack{
                Text(category.title ?? "")
                Spacer()
//                        Text("\(filteredSubCategories.count) / \(category.subCategory.count)")
            }
            .foregroundColor((category.rating ?? 0.0) > 0 ? Color(category.color ?? "Lime") : .secondary)
            .font(.title3)
            .bold()
            .padding()
            .background(RoundedRectangleShape(color: .white)
                .shadow(color: Color.black, radius: 1, x: 0, y: 1))
        }
    }
}

// MARK: - SubCategory View...
//struct SubCategoryCellView: View {
//    
//    var subCategory: SubCategory
//    var color: Color
//    
//    var body: some View {
//        // if subCategory.rating > 0 {
//        NavigationLink {
//            DetailSubCategoryView(color: color, subCategory: subCategory)
//        } label: {
//            SubCategoryRowView(subCategory: subCategory)
//        }
//        // }
//    }
//}

struct SubCategoryRowView: View {
    var subCategory: SubCategory
    
    var body: some View {
        HStack {
            Text(subCategory.title ?? "")
            Spacer()
            
            //RatingSubCategoryView(rating: subCategory.rating ?? 0.0)
            
           // Text("\(subCategory.rating ?? 0.0, specifier: "%.0f") %")
        }
        .foregroundColor(subCategory.rating ?? 0.0 > 0 ? .black.opacity(0.9) : .black.opacity(0.4))
        .padding()
        .background(
            RoundedRectangleShape(color: .white)
                .shadow(color: Color.black, radius: 1, x: 0, y: 1)
        )
    }
}
