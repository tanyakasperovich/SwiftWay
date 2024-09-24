//
//  TipView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 29.11.23.
//

import SwiftUI

// MARK: - Tip View...
struct TipCardView: View {
    @StateObject var tipViewModel = TipViewModel()
    @State var isFavoriteTip: Bool = false
    //var color: Color

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
            Image(systemName: "sparkles")
                .foregroundStyle(Color.theme.fontColor.opacity(0.7))
                .bold()
                .padding(.trailing, 5)
                
                HeaderText(text: ("Tip Of The Day").uppercased(), color: .theme.fontColorBW.opacity(0.7))
        }
        .padding(.horizontal)
        .padding(.bottom, 5)
        
            CardView(content:
                        VStack {
                if let tip = tipViewModel.tip {
                    VStack {
                        
                        //                                    HStack {
                        //                                        Spacer()
                        //
                        //                                        Button {
                        //                                            tipsViewModel.addUserFavoriteTip(tipId: tip.id)
                        //                                            isFavoriteTip = true
                        //                                        } label: {
                        //                                            Image(systemName: isFavoriteTip ? "heart.fill" : "heart")
                        //                                                .foregroundColor(.pink)
                        //                                        }
                        //
                        //                                    }
                        
                        //                                    Circle()
                        //                                        .opacity(0.4)
                        //                                        .frame(height: 30)
                        
                        Text("Совет дня")
                            .font(.body)
                            .bold()
                            .padding(.vertical, 8)
                            .foregroundStyle(Color.theme.fontColorBW)
                            .opacity(0.9)
                        
                        Text(tip.title ?? "")
                            .font(.body)
                            .foregroundStyle(Color.theme.fontColorBW)
                            .opacity(0.7)
                    }
                } else {
                    ProgressView()
//                    Text("No Item")
//                        .foregroundStyle(Color.secondary)
                }
            }
                                         ,
                     color: .accentColor)

            
//            TabView() {
//                ForEach(tipViewModel.tips.shuffled()) { tip in
//                    CardView(content:
//                                VStack {
//                        if tipViewModel.isLoadingTips {
//                            ProgressView()
//                        } else {
//                            if !tipViewModel.tips.isEmpty {
//                                
//                                //                        ForEach(tipsViewModel.tips) { tip in
//                                VStack {
//                                    
////                                    HStack {
////                                        Spacer()
////                                        
////                                        Button {
////                                            tipsViewModel.addUserFavoriteTip(tipId: tip.id)
////                                            isFavoriteTip = true
////                                        } label: {
////                                            Image(systemName: isFavoriteTip ? "heart.fill" : "heart")
////                                                .foregroundColor(.pink)
////                                        }
////                                        
////                                    }
//                                    
////                                    Circle()
////                                        .opacity(0.4)
////                                        .frame(height: 30)
//                                    
//                                    Text("Совет дня")
//                                        .font(.body)
//                                        .bold()
//                                        .padding(.vertical, 8)
//                                        .foregroundStyle(Color.theme.fontColorBW)
//                                        .opacity(0.9)
//                                    
//                                    Text(tip.title ?? "")
//                                        .font(.body)
//                                        .foregroundStyle(Color.theme.fontColorBW)
//                                        .opacity(0.7)
//                                }
//                                //}
//                                
//                            } else {
//                                Text("No Item")
//                                    .foregroundStyle(Color.secondary)
//                            }
//                        }
//                        Spacer()
//                    }
//                             ,
//                             color: color)
//                   // .padding(.top, 5)
//                    .padding(5)
//                }
//            }
//            .tabViewStyle(.page)
        }
        .frame(height: 300)
        //.padding(.bottom, 25)
        .task {
           // try? await tipViewModel.getTipOfTheDay()
            try? await tipViewModel.getTip()
        }
      
    }
}

#Preview {
    TipCardView()
}
