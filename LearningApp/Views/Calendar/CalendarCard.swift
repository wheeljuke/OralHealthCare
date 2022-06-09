//
//  CalendarCard.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/5/26.
//

import SwiftUI

struct CalendarCard: View {
    
    var color = Color.white
    var height = 48
    var date: Date
    var duration: TimeInterval
    
    let formatter = RelativeDateTimeFormatter()
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
            
                .foregroundColor(color)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(height: CGFloat(height))
            
            HStack {
                
                Spacer()
                
                VStack {
                    
                    Text("日期")
                        .font(.caption)
                    
                    Text(date, style: .date)
                        .font(.title)
                }
                
                Spacer()
                
                VStack {
                    Text("時長")
                        .font(.caption)
                    
                    Text(String(format:"%.0f",duration) + "秒")
                        .font(.title)
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

/*
struct CalendarCard_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCard()
    }
}
 */
