//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/3/29.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        
        let url = URL(string: Constants.videoHostURL + (lesson?.video ?? ""))
        
        VStack {
            // only show video if we get a valid url
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            // Description
            CodeTextView()
            
            // Next lesson button
            if model.hasNextLesson() {
                
                Button {
                    //Advance the lesson
                    model.nextLesson()
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .frame(height: 48)
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .bold()
                            .foregroundColor(.white)
                    }
                }

            }
            
        }
        .padding(.horizontal)
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
            .environmentObject(ContentModel())
    }
}
