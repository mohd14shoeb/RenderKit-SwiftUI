//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-01-03.
//

import Foundation
import SwiftUI

struct Config {
    let background = LinearGradient(colors: [.gray.opacity(0.9),.white.opacity(0.5)], startPoint: UnitPoint.top, endPoint: .bottom)
    let backgroundColor = Color.gray
    let backgroundBorder = Color.black
    let backgroundOpacity = 0.9
   
    let borderWidth = 2.0
    let borderCornerRadius = 0.0
    let borderControlWidth = 4.0
    let padding = 15.0
    let textColor = Color.white
    let textColorOff = Color.white
  
}
