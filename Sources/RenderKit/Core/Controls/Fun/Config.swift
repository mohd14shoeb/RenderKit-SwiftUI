//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-01-03.
//

import Foundation
import SwiftUI

struct Config {
    let background = //Color.clear
    LinearGradient(colors: [.blue.opacity(0.2),.white.opacity(0.4)], startPoint: UnitPoint.top, endPoint: .bottom)
    let backgroundColor = Color.gray
    let backgroundBorder = Color.black
    let backgroundOpacity = 0.9
   
    let borderWidth = 2.0
    let borderCornerRadius = 0.0
    let borderControlWidth = 4.0
    let padding = 15.0
    let textColor = Color.black
    let textColorOff = Color.white
    
    // This will effect all the RenderButton and Segment and Search Control
    // if Circle() segmentControl is forced to Rectangle() by passing Shape
    let buttonShape =
    //Rectangle()
    //Circle() //Todo fix segementControl
    Capsule()
    //RoundedRectangle(cornerRadius: 10.0)
  
}
