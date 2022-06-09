//
//  TestView.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/4/4.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    // MARK: - Variables that need to be reset every question
    @State var selectedAnswerIndex:Int?
    @State var submitted = false
    
    // MARK: -
    @State var numQuestionCorrect = 0
    
    var body: some View {
        
        // MARK: - Question title and description
        if model.currentQuestion != nil {
            VStack(alignment: .center, spacing: 5) {
                
                // Question Number
                Text("第 \(model.currentQuestionIndex + 1) / \(model.currentModule?.test.questions.count ?? 0) 題")

                // Question
                //CodeTextView()
                Text(model.currentQuestion!.content)
            }
            .navigationTitle("\(model.currentModule?.category ?? "")小挑戰")
            .padding(.horizontal)
            
            // MARK: - Answers selection
            ScrollView {
                
                VStack {
                    
                    ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
                        
                        // MARK: Button for the answers
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
                
                
            }
            
            VStack {
                // MARK: Submit Button
                Button {
                    
                    // Reset the question for the next Question
                    if submitted == true {
                        
                        // Advance to the next question
                        model.nextQuestion()
                        
                        // Reset properties
                        selectedAnswerIndex = nil
                        submitted = false
                    }
                    
                    // Submit the answers
                    else {
                        
                        if selectedAnswerIndex != nil {
                            
                            // Mark the state to be submitted
                            submitted = true
                            
                            //Check the answers and record the number of correct questions
                            if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                                numQuestionCorrect += 1
                            }
                        }
                    }
                    
                    
                } label: {
                    
                    ZStack {
                        
                        RectangleCard(color: .green)
                        
                            Text(buttonText
                            )
                                .bold()
                                .foregroundColor(.white)
                    }
                    .padding()
                }
            }
        }
        else if model.currentQuestion == nil {
            
            TestResultView(numQuestionCorrect: numQuestionCorrect)
        }
        else {
            
            ProgressView()
        }
    }
    
    var buttonText: String {
        // Check if answer has been submitted
        if submitted == true {
            
            if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count {
                
                return "結束"
            }
            
            else {
                
                return "下一題"
            }
            
        }
        else {
            
            return "送出答案"
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
