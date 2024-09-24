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
    let aquaColor = Color("Aqua")
    let cardColor = Color("CardColor")
    let fontColorWB = Color("FontColorWB")
    let fontColorBW = Color("FontColorBW")
    let fontColor = Color("FontColor")

    // Основные цвета
    let primary = Color("PrimaryPurple")
    let secondary = Color("SecondaryBlue")
    let accent = Color("AccentOrange")

    // Фоновые цвета
    let background = Color("BackgroundLight")
    let surface = Color("SurfaceWhite")
    let card = Color("CardWhite")

    // Текст
    let textPrimary = Color("TextPrimary")
    let textSecondary = Color("TextSecondary")
    let textTertiary = Color("TextTertiary")

    // Статусы
    let success = Color("SuccessGreen")
    let warning = Color("WarningYellow")
    let error = Color("ErrorRed")
    let info = Color("InfoBlue")

    // Специальные для обучения
    let beginner = Color("BeginnerGreen")
    let intermediate = Color("IntermediateOrange")
    let advanced = Color("AdvancedRed")
    let expert = Color("ExpertPurple")

    // Градиенты
    var primaryGradient: LinearGradient {
        LinearGradient(
            colors: [Color("PrimaryPurple"), Color("SecondaryBlue")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    var accentGradient: LinearGradient {
        LinearGradient(
            colors: [Color("AccentOrange"), Color("WarningYellow")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    var successGradient: LinearGradient {
        LinearGradient(
            colors: [Color("SuccessGreen"), Color("MintGreen")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
