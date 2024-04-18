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
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .foregroundColor(selectedView ? .white : .secondary)
                    .padding()
                    .padding(.horizontal)
                    .background(RoundedRectangleShape(color: .accentColor) .opacity(selectedView ? 1 : 0))
            }
            
            Button {
                selectedView = false
            } label: {
                Image(systemName: "map.fill")
                    .foregroundColor(selectedView ? .secondary : .white)
                    .padding()
                    .padding(.horizontal)
                    .background(RoundedRectangleShape(color: .accentColor)
                        .opacity(selectedView ? 0 : 1))
            }
        }
        .background(RoundedRectangleShape(color: .accentColor).opacity(0.2))
        .padding(.top)
    }
}


#Preview {
    CustomPickerView(selectedView: .constant(false))
}
