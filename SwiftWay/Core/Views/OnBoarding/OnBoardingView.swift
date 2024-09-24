//
//  OnBoardingView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

//// MARK: - Onboarding DATA MODEL
//struct OnboardingModel {
//    let id: Int
//    let title: String
//    let Description: String
//    let color: Color
//}
//// MARK: - TABS DATA
//var tabs: [OnboardingModel] = [
//    OnboardingModel(id: 0, title: "1", Description: "", color: .accentColor),
//    OnboardingModel(id: 1, title: "2", Description: "", color: .theme.darkPinkColor),
//    OnboardingModel(id: 2, title: "3", Description: "", color: .theme.iceColor),
//]
//
//// MARK: - OnboardingView
//struct OnboardingView: View {
//    @State private var showingTab = 0
//   @AppStorage("isShowingOnboarding") var isShowingOnboarding: Bool?
//    
//    var body: some View {
//            ZStack {
//                RoundedRectangleShape(color: .accentColor)
//                    .ignoresSafeArea()
//                VStack {
//                    HStack {
//                        Spacer()
//                        Button {
//                            isShowingOnboarding = false
//                        } label: {
//                            Image(systemName: "xmark")
//                                .foregroundStyle(Color.theme.cardColor).opacity(0.8)
//                                .padding()
//                        }
//                    }
//                    
//                    ForEach(tabs, id: \.id) {item in
//                        if showingTab == item.id {
//                            ZStack {
//                                RoundedRectangleShape(color: Color.theme.cardColor)
//                                    .shadow(color: Color.black, radius: 1, x: 0, y: 1)
//                                    .padding()
//                                
//                                VStack(alignment: .center) {
//                                    HeaderText(text: item.title, color: .accentColor)
//                                }
//                                .foregroundStyle(item.color)
//                            }
//                            //.transition(.pivot)
//                            .transition(.asymmetric(insertion: .scale, removal: .pivot))
//                        }
//                    }
//                    
//                    Button {
//                        withAnimation {
//                            showingTab += 1
//                        }
//                        if showingTab == tabs.count {
//                            isShowingOnboarding = false
//                        }
//                    } label: {
//                        ButtonView(content: HeaderText(text: "Next", color: .accentColor).padding(), backgroundColor: .theme.cardColor)
//                        }
//                    
//                }
//            }
//    }
//}
//
//
//#Preview {
//    OnboardingView()
//}
//
//
//struct CornerRotateModifier: ViewModifier {
//    let amount: Double
//    let anchor: UnitPoint
//    
//    func body(content: Content) -> some View {
//        content
//            .rotationEffect(.degrees(amount), anchor: anchor)
//            .clipped()
//    }
//}
//
//extension AnyTransition {
//    static var pivot: AnyTransition {
//        .modifier(
//            active: CornerRotateModifier(amount: -90, anchor: .bottomLeading),
//            identity: CornerRotateModifier(amount: 0, anchor: .bottomLeading))
//    }
//}
//

// MARK: - OnboardingView
struct OnboardingView: View {
    @AppStorage("isShowingOnboarding") var isShowingOnboarding = true
    @State private var currentPage = 0

    let pages = [
        OnboardingPage(
            title: "Learn Your Way",
            description: "Create your personalized learning path and master new skills",
            image: "book.circle.fill",
            color: .theme.primary
        ),
        OnboardingPage(
            title: "Track Progress",
            description: "Watch your skills grow with detailed progress tracking",
            image: "chart.line.uptrend.xyaxis",
            color: .theme.secondary
        ),
        OnboardingPage(
            title: "Learn Offline",
            description: "Download lessons and learn anytime, anywhere",
            image: "wifi.slash",
            color: .theme.accent
        )
    ]

    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()

            TabView(selection: $currentPage) {
                ForEach(pages.indices, id: \.self) { index in
                    OnboardingPageView(page: pages[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))

            VStack {
                Spacer()

                Button {
                    if currentPage < pages.count - 1 {
                        withAnimation {
                            currentPage += 1
                        }
                    } else {
                        isShowingOnboarding = false
                    }
                } label: {
                    Text(currentPage < pages.count - 1 ? "Next" : "Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [pages[currentPage].color, pages[currentPage].color.opacity(0.7)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(15)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
            }
        }
    }
}

struct OnboardingPage: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let image: String
    let color: Color
}

struct OnboardingPageView: View {
    let page: OnboardingPage
    @State private var isAnimating = false

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            // Animated image
            Image(systemName: page.image)
                .font(.system(size: 120))
                .foregroundColor(page.color)
                .scaleEffect(isAnimating ? 1 : 0.8)
                .opacity(isAnimating ? 1 : 0)

            Text(page.title)
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundColor(.theme.textPrimary)
                .offset(y: isAnimating ? 0 : 20)
                .opacity(isAnimating ? 1 : 0)

            Text(page.description)
                .font(.system(size: 17, weight: .regular))
                .multilineTextAlignment(.center)
                .foregroundColor(.theme.textSecondary)
                .padding(.horizontal, 40)
                .offset(y: isAnimating ? 0 : 30)
                .opacity(isAnimating ? 1 : 0)

            Spacer()
            Spacer()
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                isAnimating = true
            }
        }
    }
}
