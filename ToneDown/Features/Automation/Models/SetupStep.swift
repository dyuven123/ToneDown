//
//  SetupStep.swift
//  ToneDown
//
//  Created by Dyuven on 10.08.2025.
//

import SwiftUI

// MARK: - Setup Step Model
struct SetupStep {
    let number: Int
    let title: String
    let description: String
    let action: String
    let icon: String
    let color: Color
    let video: String? // Имя видео файла из Assets
}
