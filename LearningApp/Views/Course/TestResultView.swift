//
//  TestResultView.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/4/7.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model: ContentModel
    
    @State var numQuestionCorrect: Int
    
    var body: some View {
        
        if model.currentModule != nil {
            
            VStack {
                
                Spacer()
                
                Text(resultHeading)
                    .font(.title)
                
                Spacer()
                
                Text("你答對\(model.currentModule!.test.questions.count)中的\(numQuestionCorrect)題")
                
                Spacer()
                
                Button {
                    
                    // Send the user back to home view
                    model.currentTestSelected = nil
                    
                } label: {
                    
                    ZStack {
                        
                        RectangleCard(color: .green)
                        
                        Text("完成")
                            .bold()
                            .foregroundColor(.white)
                    }
                        
                }

            }
            .padding()
        }
        else {
            
            ProgressView()
        }
    }
    
    var resultHeading: String {
        
        guard model.currentModule != nil else {
            return ""
        }
        
        let percentage = Double(numQuestionCorrect) / Double(model.currentModule!.test.questions.count)
        
        if percentage == 1.0 {
            return "哇！你超棒！你全對！"
        }
        else if percentage > 0.5 {
            return "讚讚"
        }
        else if percentage > 0.2 {
            return "很不錯呦"
        }
        else {
            return "繼續學習"
        }
    }
}
