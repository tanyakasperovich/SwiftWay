//
//  LinearProgressView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

struct LinearProgressView: View {
    var progress: Double
    var level: Level
    
    var body: some View {
        HStack {
            Text("Progress: ")
                .bold()
                .foregroundStyle(Color.theme.fontColorBW).opacity(0.6)
            Text("\(level.rating ?? 0.0, specifier: "%.0f") %")
                .font(.body)
                .bold()
                .padding(.horizontal, 5)
                .foregroundStyle(Color.theme.fontColorBW).opacity(0.6)
         
            Spacer()
            
            ProgressView(value: progress)
        }
        .accentColor(.yellow)
    }
}

#Preview {
    LinearProgressView(progress: 0.3, level: RoadMapViewModel().levels[0])
}

struct DateRelativeProgressView: View {
    let workoutDateRange = Date()...Date().addingTimeInterval(5*60)

    var body: some View {
         ProgressView(timerInterval: workoutDateRange) {
             Text("Workout")
         }
    }
}
