//
//  TestView.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/4/4.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex:Int?
    @State var submitted = false
    @State var numQuestionCorrect = 0
    
    var body: some View {
        
        if model.currentQuestion != nil {
            VStack(alignment: .leading) {
                
                // Question Number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                
                // Question
                CodeTextView()
                
                // Answers
                
                // Buttons
                
            }
            .navigationTitle("\(model.currentModule?.category ?? "") Test")
            .padding(.horizontal)
            
            // MARK: Answers selection
            ScrollView {
                
                VStack {
                    
                    ForEach(0..<model.currentQuestion!.answers.count) { index in
                        
                        Button {
                            
                            selectedAnswerIndex = index
                        } label: {
                            ZStack {
                                
                                // Answer hasn't been submitted
                                if submitted == false {
                                    RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                }
                                
                                // Answer has been submitted
                                else {
                                    
                                    // User has selected the corrent answer change the correct answer to green
                                    if index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex {

                                        RectangleCard(color: .green)
                                    }
                                    
                                    // User has selected the wrong answer change the wrong answer to red
                                    else if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex {
                                        
                                        RectangleCard(color: .red)
                                    }
                                    
                                    // User has selected the wrong answer change the correct answer to green
                                    else if index != selectedAnswerIndex && index == model.currentQuestion!.correctIndex {
                                        
                                        RectangleCard(color: .green)
                                    }
                                    
                                    else {
                                        RectangleCard(color: .white)
                                    }
                                }
                                
                                Text(model.currentQuestion!.answers[index])
                            }
                        }
                        .disabled(submitted)
                        .opacity(1)
                    }
                }
                .padding()
                .accentColor(.black)
                
                // MARK: Submit Button
                Button {
                    
                    // Mark the state to be submitted
                    submitted = true
                    
                    //Check the answers and record the number of correct questions
                    if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                        numQuestionCorrect += 1
                    }
                    
                } label: {
                    
                    ZStack {
                        
                        RectangleCard(color: .green)
                        
                        Text("Submit")
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                // Make sure that when no answers were selected it can't be submitted
                .disabled(selectedAnswerIndex == nil || submitted == true)
            }
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
