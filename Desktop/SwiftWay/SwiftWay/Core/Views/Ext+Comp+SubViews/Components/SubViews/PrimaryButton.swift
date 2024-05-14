//
//  PrimaryButton.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

struct ButtonView<Content: View>: View {
    let content: Content
    var backgroundColor: Color
    
    var body: some View {
        content
                .padding(8)
                .background(RoundedRectangleShape(color: backgroundColor)
                    .shadow(color: Color.black, radius: 2, x: 0, y: 1)
                    .padding(3)
                )
    }
}
    
//struct PrimaryButton: View {
//    
//    var text: String
//    var backgroundColor: Color
//    var textColor: Color
//    
//    var body: some View {
//        
//        ZStack {
//            RoundedRectangleShape(color: backgroundColor)
//                .shadow(color: Color.black, radius: 2, x: 0, y: 1)
//                .padding(2)
//            Text(text)
//                .font(.headline)
//                .padding()
//            //.padding(.vertical)
//                .foregroundColor(textColor)
//        }
//    }
//}

#Preview {
    VStack(spacing: 10) {
        ButtonView(content: Text("Button").padding(.vertical, 12).padding(.horizontal).padding(5), backgroundColor: Color.pink)
       // PrimaryButton(text: "Text", backgroundColor: Color.pink, textColor: Color.white)
        CirclePrimaryButton(imageName: "plus", backgroundColor: Color.blue, imageColor: Color.white)
         
        PBView(content: Text("Button").padding(.vertical, 12).padding(.horizontal), color: Color.pink, isSet: .constant(false))
    }
    .padding()
    .background {
        Color.theme.fontColorBW
            .opacity(0.5)
    }
}

struct CirclePrimaryButton: View {
    
    var imageName: String
    var backgroundColor: Color
    var imageColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangleShape(color: backgroundColor)
                .shadow(color: Color.black, radius: 2, x: 0, y: 2)
                .padding(3)
                .frame(width: 50, height: 50)
            
            Image(systemName: imageName)
                .foregroundStyle(Color.white)
        }
    }
}

struct PBView<Content: View>: View {
    var content: Content
    var color: Color
    @Binding var isSet: Bool
    
    var body: some View {

            content
            .bold()
                .padding(8)
                .foregroundColor(isSet ? .white : color)
                .opacity(isSet ? 1 : 0.9)
                .background {
                    ZStack {
                        RoundedRectangleShape(color: .white)
                            .opacity(0.7)
                           // .frame(height: 55)
                            .shadow(color: color, radius: 1, x: 2, y: 1)
                            .shadow(color: Color.black, radius: 2, x: 0, y: 1)

                        
                        RoundedRectangleShape(color: color)
                            .opacity(isSet ? 1 : 0.2)
                            //.frame(height: 55)
                    }
                    .padding(3)
                }
      
    }
}
