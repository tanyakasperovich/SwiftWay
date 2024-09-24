//
//  ProgressBar.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

struct ProgressBar: View {
    var progress: CGFloat
    var color: Color
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(maxWidth: 350, maxHeight: 4)
                .foregroundColor(.gray.opacity(0.4))
                .cornerRadius(10)
            
            Rectangle()
                .frame(width: progress, height: 4)
                .foregroundColor(color)
                .cornerRadius(10)
        }
    }
}

#Preview {
    ProgressBar(progress: 50, color: .accentColor)
}
