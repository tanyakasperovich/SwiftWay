//
//  CustomText.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 11.04.24.
//

import SwiftUI

struct HeaderText: View {
    var text: String
    var color: Color

    var body: some View {
        Text(text)
            .bold()
            .font(.headline)
            .foregroundStyle(color)
    }
}

#Preview {
    VStack(spacing: 10) {
        HeaderText(text: "HeaderText", color: .theme.fontColorBW)
        SubHeaderText(text: "SubHeaderText", color: .theme.fontColorBW)
        SmallText(text: "SmallText", color: .secondary)
    }
}

struct SubHeaderText: View {
    var text: String
    var color: Color

    var body: some View {
        Text(text)
            .font(.subheadline)
            .foregroundStyle(color)
    }
}

struct SmallText: View {
    var text: String
    var color: Color

    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(color)
    }
}

// MARK: - TextStyles.swift
struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 34, weight: .bold, design: .rounded))
            .foregroundColor(.theme.textPrimary)
    }
}

struct HeadlineStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28, weight: .semibold, design: .rounded))
            .foregroundColor(.theme.textPrimary)
    }
}

struct SubheadlineStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .medium, design: .rounded))
            .foregroundColor(.theme.textSecondary)
    }
}

struct BodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .regular, design: .default))
            .foregroundColor(.theme.textSecondary)
    }
}

struct CaptionStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12, weight: .medium, design: .rounded))
            .foregroundColor(.theme.textTertiary)
    }
}

extension View {
    func titleStyle() -> some View { modifier(TitleStyle()) }
    func headlineStyle() -> some View { modifier(HeadlineStyle()) }
    func subheadlineStyle() -> some View { modifier(SubheadlineStyle()) }
    func bodyStyle() -> some View { modifier(BodyStyle()) }
    func captionStyle() -> some View { modifier(CaptionStyle()) }
}

//struct HeaderText: View {
//    var text: String
//    var color: Color
//    
//    var body: some View {
//        Text(text)
//            .bold()
//            .font(.headline)
//            .foregroundStyle(color)
//    }
//}
//
//#Preview {
//    VStack(spacing: 10) {
//        HeaderText(text: "HeaderText", color: .theme.fontColorBW)
//        SubHeaderText(text: "SubHeaderText", color: .theme.fontColorBW)
//        SmallText(text: "SmallText", color: .secondary)
//    }
//}
//
//struct SubHeaderText: View {
//    var text: String
//    var color: Color
//    
//    var body: some View {
//        Text(text)
//            .font(.subheadline)
//            .foregroundStyle(color)
//    }
//}
//
//struct SmallText: View {
//    var text: String
//    var color: Color
//    
//    var body: some View {
//        Text(text)
//            .font(.caption)
//            .foregroundStyle(color)
//    }
//}
