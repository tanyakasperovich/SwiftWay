//
//  SpirographView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

struct SpirographView: View {
    @State private var innerRadius = 138.0
    @State private var outerRadius = 39.0
    @State private var distance = 80.0
    @State private var amount = 1.0
    @State private var hue = 0.65
    
    var body: some View {
        VStack {
            ZStack {
                Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
                    .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1.4)
                
//                Image("swift")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 200, height: 200)
//                    .shadow(color: Color.theme.purpleColor, radius: 3, x: -3, y: 5)
//                
//                Image("swift")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 200, height: 200)
//                    .shadow(color: Color.theme.blueColor, radius: 1, x: -10, y: 0)
//                    .opacity(0.2)
            }
            
            Text("Amount: \(amount, format: .number.precision(.fractionLength(2)))")
            Slider(value: $amount)
                .padding([.horizontal, .bottom])
        }
    }
}

#Preview {
    SpirographView()
}

struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: Double

    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b

        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }

        return a
    }

    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = Double(self.outerRadius)
        let innerRadius = Double(self.innerRadius)
        let distance = Double(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * Double.pi * outerRadius / Double(divisor)) * amount

        var path = Path()

        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)

            x += rect.width / 2
            y += rect.height / 2

            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }

        return path

    }
}

