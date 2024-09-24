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
