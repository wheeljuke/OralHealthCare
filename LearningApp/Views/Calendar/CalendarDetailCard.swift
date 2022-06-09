//
//  CalendarDetailCard.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/6/7.
//

import SwiftUI

struct CalendarDetailCard: View {
    
    var color = Color.white
    var height = 48
    var name: String
    var done: Bool
    var time: Int
    
    
    let formatter = RelativeDateTimeFormatter()
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
            
                .foregroundColor(color)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(height: CGFloat(height))
            
            HStack {

                VStack {
                    
                    Text("部位")
                        .font(.caption)
                    
                    Text(name)
                        .font(.title)
                }
                .frame(width: 150)
                
                Spacer()
                
                VStack {
                    
                    Text("時間")
                        .font(.caption)
                    
                    Text("\(time)秒")
                        .font(.title)
                }
                
                Spacer()
                
                VStack {
                    
                    Text("完成")
                        .font(.caption)
                    
                    if done {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.green)
                            .padding(.bottom, 5)
                            
                    }
                    else {
                        Image(systemName: "clock.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.pink)
                            .padding(.bottom, 5)
                        
                    }
                    
                }
                

            }
            .padding(.horizontal)
        }
    }
}

