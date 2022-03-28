//
//  ContentViewRow.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/3/28.
//

import SwiftUI

struct ContentViewRow: View {
    
    @EnvironmentObject var model: ContentModel
    
    var index: Int
    
    var body: some View {
        
        let lesson = model.currentModule!.content.lessons[index]
        
        ZStack(alignment: .leading) {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(height: 66)
            
            HStack(spacing: 30) {
                
                Text(String(index + 1))
                
                VStack(alignment: .leading) {
                    
                    Text(lesson.title)
                        .bold()
                    Text(lesson.duration)
                        .bold()
                    
                }
            }
            .padding(.bottom, 10)
            
        }
    }
}

struct ContentViewRow_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewRow()
            .environmentObject(ContentModel())
    }
}
