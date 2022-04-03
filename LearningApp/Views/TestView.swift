//
//  TestView.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/4/4.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        if model.currentQuestion != nil {
            VStack {
                
                // Question Number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                
                // Question
                CodeTextView()
                
                // Answers
                
                // Buttons
                
            }
            .navigationTitle("\(model.currentModule?.category ?? "") Test")
            .padding(.horizontal)
        }
        
        else {
            ProgressView()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
