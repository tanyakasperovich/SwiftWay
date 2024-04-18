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
            
            ZStack {
                RoundedRectangleShape(color: Color.theme.cardColor)
                    .shadow(color: Color.black, radius: 1, x: 0, y: 1)
                
                VStack {
                    content
                }
                .padding()
            }
            .padding(25)
        }
    }
}

#Preview {
    CardView(content: Text("123"), color: Color.accentColor)
}
