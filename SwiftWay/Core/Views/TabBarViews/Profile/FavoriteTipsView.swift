//
//  FavoriteTipsView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 22.12.23.
//

import SwiftUI

struct FavoriteTipsView: View {
    
    @StateObject private var viewModel = FavoriteTipsViewModel()

    var body: some View {
        List {
            if viewModel.isLoading {
                ProgressView()
            } else {
                if !viewModel.userFavoriteTips.isEmpty {
                    ForEach(viewModel.userFavoriteTips, id: \.id.self) { item in
                        
                        TipCellViewBuilder(tipId: item.tipId)
                            .contextMenu {
                                Button("Remove from favorites") {
                                    viewModel.removeFromFavorites(favoriteTipId: item.id)
                                }
                            }
                    }
                } else {
                    Text("Not found...")
                }
            }
            
     }
        .navigationTitle("Favorite Tips")
        .onAppear{
            viewModel.getFavoriteTips()
        }
//        .onFirstAppear {
//            viewModel.addListenerForFavorites()
//        }
        
    }
}

#Preview {
    FavoriteTipsView()
}



struct TipCellViewBuilder: View {
    
    let tipId: String
    @State private var tip: Tip? = nil
    
    var body: some View {
        ZStack {
            if let tip {
                TipCellView(tip: tip)
            }
        }
        .task {
            self.tip = try? await TipManager.shared.getTip(tipId: tipId)
        }
    }
}

struct TipCellView: View {
    
    let tip: Tip
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            
//            AsyncImage(url: URL(string: product.thumbnail ?? "")) { image in
//                image
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 75, height: 75)
//                    .cornerRadius(10)
//            } placeholder: {
//                ProgressView()
//            }
//            .frame(width: 75, height: 75)
//            .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2)

            
            VStack(alignment: .leading, spacing: 4) {
                Text((tip.title ?? "n/a"))
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .font(.callout)
            .foregroundColor(.secondary)
        }
    }
}
