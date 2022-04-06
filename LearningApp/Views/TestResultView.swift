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
                
                Text("You got \(numQuestionCorrect) out of \(model.currentModule!.test.questions.count) questions")
                
                Spacer()
                
                Button {
                    
                    // Send the user back to home view
                    model.currentTestSelected = nil
                    
                } label: {
                    
                    ZStack {
                        
                        RectangleCard(color: .green)
                        
                        Text("Complete")
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
            return "WOW you've got 100%"
        }
        else if percentage > 0.5 {
            return "Awesome"
        }
        else if percentage > 0.2 {
            return "Doing great"
        }
        else {
            return "Keep learning"
        }
    }
}
