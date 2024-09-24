//
//  CustomPickerView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 29.11.23.
//

import SwiftUI

struct CustomPickerView: View {
    @Binding var selectedView: Bool
    
    var body: some View {
        HStack {
            Button {
                selectedView = true
            } label: {
                Image(systemName: "map.fill")
                    .foregroundColor(selectedView ? .white : .secondary)
                    .padding()
                    .padding(.horizontal)
                    .background(RoundedRectangleShape(color: .accentColor) .opacity(selectedView ? 1 : 0))
            }
            
            Button {
                selectedView = false
            } label: {
                Image(systemName: "list.dash")
                    .foregroundColor(selectedView ? .secondary : .white)
                    .padding()
                    .padding(.horizontal)
                    .background(RoundedRectangleShape(color: .accentColor)
                        .opacity(selectedView ? 0 : 1))
            }
        }
        .background(
            ZStack {
                RoundedRectangleShape(color: .white)
                    .shadow(color: Color.black, radius: 2, x: 2, y: 2)
                RoundedRectangleShape(color: .accentColor).opacity(0.4)
            }
         
        )
        .padding(.top)
    }
}


#Preview {
    CustomPickerView(selectedView: .constant(false))
}
