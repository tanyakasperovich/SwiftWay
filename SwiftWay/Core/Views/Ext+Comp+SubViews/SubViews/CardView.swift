//
//  CardView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

struct CardView<Content: View>: View {
    let content: Content
    let color: Color

    var body: some View {
        ZStack {
            RoundedRectangleShape(color: color)
                .shadow(color: Color.black, radius: 2, x: 2, y: -2)
            
            PostCardView(content: content)
            .padding(25)
        }
        .padding(.trailing, 2)
    }
}

#Preview {
    CardView(content: Text("123"), color: Color.accentColor)
}

struct PostCardView<Content: View>: View {
    let content: Content

    var body: some View {
            ZStack {
                RoundedRectangleShape(color: Color.theme.cardColor)
                    .shadow(color: Color.black, radius: 1, x: 0, y: 1)
                
                VStack {
                    content
                }
                .padding(.vertical)
                .padding(.horizontal, 10)
            }
    }
}

// MARK: - ModernCard.swift
struct ModernCard<Content: View>: View {
    let content: Content
    var color: Color = .theme.card
    var hasShadow: Bool = true
    var cornerRadius: CGFloat = 20

    init(
        color: Color = .theme.card,
        hasShadow: Bool = true,
        cornerRadius: CGFloat = 20,
        @ViewBuilder content: () -> Content
    ) {
        self.color = color
        self.hasShadow = hasShadow
        self.cornerRadius = cornerRadius
        self.content = content()
    }

    var body: some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(cornerRadius)
            .shadow(
                color: hasShadow ? Color.black.opacity(0.05) : .clear,
                radius: hasShadow ? 10 : 0,
                x: 0,
                y: hasShadow ? 5 : 0
            )
    }
}

// MARK: - GradientCard.swift
struct GradientCard<Content: View>: View {
    let content: Content
    let gradient: LinearGradient
    var cornerRadius: CGFloat = 20

    init(
        gradient: LinearGradient = Color.theme.primaryGradient,
        cornerRadius: CGFloat = 20,
        @ViewBuilder content: () -> Content
    ) {
        self.gradient = gradient
        self.cornerRadius = cornerRadius
        self.content = content()
    }

    var body: some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(gradient)
            .cornerRadius(cornerRadius)
            //.shadow(color: gradient.colors.first?.opacity(0.3) ?? .clear, radius: 15, x: 0, y: 5)
    }
}

// MARK: - LevelCard
struct LevelCard: View {
    let level: Level
    @State private var isPressed = false

    var body: some View {
        GradientCard(gradient: levelGradient) {
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    // Level icon and number
                    HStack {
                        Image(systemName: levelIcon)
                            .font(.title2)
                            .foregroundColor(.white)

                        Text("LEVEL \(level.level)")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(8)
                    }

                    Text(level.title ?? "")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    // Progress bar
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("100%")
                            // Text("\(Int(level.progress * 100))%")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)

                            Spacer()

                            Text("1/4 topics")
                           // Text("\(level.completedCategories)/\(level.totalCategories) topics")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.8))
                        }

                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .fill(Color.white.opacity(0.2))
                                    .frame(height: 8)
                                    .cornerRadius(4)

                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: geometry.size.width * 20, height: 8)
//                                    .frame(width: geometry.size.width * level.progress, height: 8)
                                    .cornerRadius(4)
                            }
                        }
                        .frame(height: 8)
                    }
                }

                Spacer()

                // Chevron
                Image(systemName: "chevron.right")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .scaleEffect(isPressed ? 0.98 : 1)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        .onTapGesture {
            isPressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                isPressed = false
            }
        }
    }

    private var levelIcon: String {
        switch level.level {
        case 1: return "star.fill"
        case 2: return "flame.fill"
        case 3: return "bolt.fill"
        case 4: return "crown.fill"
        default: return "book.fill"
        }
    }

    private var levelGradient: LinearGradient {
        switch level.level {
        case 1: return LinearGradient(
            colors: [Color.green, Color.mint],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        case 2: return LinearGradient(
            colors: [Color.orange, Color.yellow],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        case 3: return LinearGradient(
            colors: [Color.red, Color.orange],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        default: return LinearGradient(
            colors: [Color.purple, Color.pink],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        }
    }
}
