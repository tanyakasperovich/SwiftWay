//
//  CircleImage.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 26.03.24.
//

import SwiftUI

struct CircleImage: View {
    var image: Image

    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .clipShape(Circle())
            .overlay {
                Circle().stroke(Color.white, lineWidth: 4)
            }
            .shadow(radius: 5)
    }
}

struct ProfileImage: View {
    var image: Image

    var body: some View {
        ZStack {
        Color.accentColor
          
        image
            .resizable()
            .scaledToFill()
    }
            .clipShape(Circle())
            .shadow(color: Color.black, radius: 1, x: 1, y: -1)
            .padding(.top, 2)
    }
}


#Preview {
    CircleImage(image: Image("swift"))
}
