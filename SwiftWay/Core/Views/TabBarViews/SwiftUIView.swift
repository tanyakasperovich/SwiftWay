//
//  SwiftUIView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 21.05.24.
//

import SwiftUI

struct SwiftUIView: View {
    @State var selectedProfession: String = ""
    var body: some View {
        VStack {
            ButtonView(content:
                        VStack {
                Image(systemName: "play.fill")
                    .foregroundStyle(Color.accentColor)
                    .grayscale(4.0)
                    .hueRotation(Angle.degrees(20))
                    .frame(width: 32, height: 32)
            },
                       backgroundColor: .accentColor)
//            
//            ButtonView(content:
//                        VStack {
//                Image(systemName: "play.fill")
//                    .foregroundStyle(Color.accentColor)
//                    //.hueRotation(Angle.degrees(170))
//                    .grayscale(5.0)
//                    .frame(width: 32, height: 32)
//            },
//                       backgroundColor: .accentColor)
            
            ButtonView(content:
                        VStack {
                Image(systemName: "play.fill")
                    .foregroundStyle(Color.theme.purpleColor)
                    .grayscale(4.0)
                    .hueRotation(Angle.degrees(20))
                    .frame(width: 32, height: 32)
            },
                       backgroundColor: .theme.purpleColor)
            
            Picker(
                selection: $selectedProfession,
                label:
                    HStack {
                        Text("Filter:")
                        Text(selectedProfession)
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 10)
                ,
                content: {
                    ForEach(["String1", "String2", "String3"], id: \.self) { profession in
                        HStack {
                            Text(profession)
                        }
                        .tag(profession)
                    }
            })
            .pickerStyle(MenuPickerStyle())
            .onFirstAppear {
                selectedProfession = "String1"
            }
        }
    }
}

#Preview {
    SwiftUIView()
}
