//
//  DesignSystem.swift
//  Grayscale
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

enum DS {
    enum Color {
        // Светлая палитра
        static let backgroundLight = SwiftUI.Color(red: 248/255, green: 250/255, blue: 252/255) // #F8FAFC
        static let card = SwiftUI.Color.white
        static let textPrimary = SwiftUI.Color(red: 11/255, green: 16/255, blue: 32/255) // #0B1020
        static let textSecondary = SwiftUI.Color(red: 107/255, green: 114/255, blue: 128/255) // #6B7280
        static let accent = SwiftUI.Color(red: 79/255, green: 70/255, blue: 229/255) // #4F46E5

        // Тёмная палитра (авто-адаптация)
        static let backgroundDark = SwiftUI.Color(red: 16/255, green: 18/255, blue: 24/255)
        static let cardDark = SwiftUI.Color(red: 28/255, green: 30/255, blue: 38/255)
    }

    enum Typo {
        static let title = Font.system(.largeTitle, design: .default).weight(.semibold) // 34
        static let subtitle = Font.system(.body, design: .default)
        static let button = Font.system(.title3, design: .default).weight(.semibold)
        static let chip = Font.system(.footnote, design: .default)
        static let caption = Font.system(.caption, design: .default)
    }

    enum Shadow {
        static let soft = SwiftUI.Color.black.opacity(0.1)
    }
}
