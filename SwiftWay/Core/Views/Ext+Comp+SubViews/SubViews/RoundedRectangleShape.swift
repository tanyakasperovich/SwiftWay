//
//  RoundedRectangleShape.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

struct RoundedRectangleShape: View {
    var color: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(color)
            .shadow(color: Color.gray.opacity(0.6),radius: 4, x: -4, y: 4)
              .overlay(
                  RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .stroke(color, lineWidth: 4)
                      .shadow(color: Color.white, radius: 6, x: 7, y: 7)
              )
              .overlay(
                  RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .stroke(color, lineWidth: 4)
                      .shadow(radius: 6, x: -7, y: -7)
              )
              .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
    }
}

#Preview {
    RoundedRectangleShape(color: Color.theme.blueColor)
}
