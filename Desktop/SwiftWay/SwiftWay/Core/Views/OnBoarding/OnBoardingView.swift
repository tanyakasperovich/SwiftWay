//
//  OnBoardingView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

// MARK: - Onboarding DATA MODEL
struct OnboardingModel {
    let id: Int
    let title: String
    let Description: String
    let color: Color
}
// MARK: - TABS DATA
var tabs: [OnboardingModel] = [
    OnboardingModel(id: 0, title: "1", Description: "", color: .accentColor),
    OnboardingModel(id: 1, title: "2", Description: "", color: .theme.darkPinkColor),
    OnboardingModel(id: 2, title: "3", Description: "", color: .theme.iceColor),
]

struct OnboardingView: View {
    @State private var showingTab = 0
   @AppStorage("isShowingOnboarding") var isShowingOnboarding: Bool?
    
    var body: some View {
            ZStack {
                RoundedRectangleShape(color: .accentColor)
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            isShowingOnboarding = false
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundStyle(Color.theme.cardColor).opacity(0.8)
                                .padding()
                        }
                    }
                    
                    ForEach(tabs, id: \.id) {item in
                        if showingTab == item.id {
                            ZStack {
                                RoundedRectangleShape(color: Color.theme.cardColor)
                                    .shadow(color: Color.black, radius: 1, x: 0, y: 1)
                                    .padding()
                                
                                VStack(alignment: .center) {
                                    HeaderText(text: item.title, color: .accentColor)
                                }
                                .foregroundStyle(item.color)
                            }
                            //.transition(.pivot)
                            .transition(.asymmetric(insertion: .scale, removal: .pivot))
                        }
                    }
                    
                    Button {
                        withAnimation {
                            showingTab += 1
                        }
                        if showingTab == tabs.count {
                            isShowingOnboarding = false
                        }
                    } label: {
                        ButtonView(content: HeaderText(text: "Next", color: .accentColor).padding(), backgroundColor: .theme.cardColor)
                        }
                    
                }
            }
    }
}


#Preview {
    OnboardingView()
}


struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .bottomLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .bottomLeading))
    }
}

