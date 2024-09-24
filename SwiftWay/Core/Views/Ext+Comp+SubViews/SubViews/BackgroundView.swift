//
//  BackgroundView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

struct BackgroundView: View {
    var color: Color
    var image: String
    var body: some View {
        ZStack {
            color
                .opacity(0.05)
                .ignoresSafeArea()

            let rows = [GridItem(), GridItem(), GridItem(),  GridItem(),  GridItem(), GridItem(),  GridItem(), GridItem(),  GridItem()]
            LazyHGrid(rows: rows) {
                            ForEach(0...100, id: \.self) { value in
                                Image(systemName: image)
                                    .opacity(0.4)

                                    Text(" ")
                            }
                            .foregroundColor(color)
                            .opacity(0.4)
                        }
        }
    }
}

#Preview {
    BackgroundView(color: .accentColor, image: "swift")
}
