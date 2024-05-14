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
