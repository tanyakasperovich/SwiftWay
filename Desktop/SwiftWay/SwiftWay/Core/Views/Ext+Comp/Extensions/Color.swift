//
//  Color.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let orangeColor = Color("Orange")
    let purpleColor = Color("Purple")
    let blueColor = Color("Blue")
    let pinkColor = Color("Pink")
    let yellowColor = Color("Yellow")
    let iceColor = Color("Ice")
    let redColor = Color("Red")
    let darkPinkColor = Color("DarkPink")
    let limeColor = Color("Lime")
    let cardColor = Color("CardColor")
    let fontColorWB = Color("FontColorWB")
    let fontColorBW = Color("FontColorBW")
    let fontColor = Color("FontColor")
    
    }

enum SelecledColor: String {
    case swift = "Orange"
    case swiftUI = "Purple"
    case uIKit = "Blue"
    case accent = "AccentColor"
}

