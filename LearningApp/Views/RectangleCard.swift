//
//  RectangleCard.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/4/3.
//

import SwiftUI

struct RectangleCard: View {
    
    var color = Color.white
    var height = 48
    
    var body: some View {
        
        Rectangle()
            .foregroundColor(color)
            .cornerRadius(10)
            .shadow(radius: 5)
            .frame(height: CGFloat(height))
    }
}
