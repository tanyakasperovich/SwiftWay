//
//  RoadMapSectionView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 13.04.24.
//

import SwiftUI

// MARK: - RoadMap Card View...
struct RoadMapSectionView: View {
    @EnvironmentObject var roadMapViewModel: RoadMapViewModel

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
                                        .padding()
                                } else {
                                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                                        let sortedLevels = roadMapViewModel.levels.sorted(by: { $0.level ?? 0 < $1.level ?? 0})
                                            ForEach(sortedLevels) { level in
                                            NavigationLink {
                                                LevelDetail(level: level)
                                            } label: {
                                                LevelCard(level: level)
                                            }
                                        }
                                    }
                                }
                            }
                    }
                    ,
                color: Color(roadMapViewModel.selectedProfession?.color ?? "Lime"))
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    RoadMapSectionView()
        .environmentObject(RoadMapViewModel())
}

struct LevelCard: View {
    var level: Level
    
    var body: some View {
        ButtonView(
            content:
                VStack(alignment: .leading) {
                    Spacer()
                    Text(level.title ?? "")
                        .font(.headline)
                        .foregroundStyle(Color.white)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                    Spacer()
                },
            backgroundColor: .pink)
    }
}

struct LevelDetail: View {
    var level: Level
    @State private var showCategory = false
    
    var body: some View {
        ScrollView {
            ForEach(level.categories ?? []) { category in
                DisclosureGroup(
                    isExpanded: $showCategory,
                    content: {
                        CategoryDetail(category: category)
                    },
                    label: {
                        CategoryRow(category: category)
                    }
                )
                .padding()
                .accentColor(.white)
                .bold()
                .background(
                        RoundedRectangleShape(color:  Color(category.color ?? ""))
                )
                        .padding(.horizontal, 3)
                }
        }
        .navigationTitle(level.title ?? "")
      //  .background(BackgroundView(color: Color(selectedProfession.color ?? ""), image: selectedProfession.image ?? ""))
    }
}

struct CategoryRow: View {
    var category: Category
    
    var body: some View {
        VStack {
            Text(category.title ?? "")
                .foregroundColor(.white)
                .font(.title3)
                .bold()
                .padding()
        }
    }
}
