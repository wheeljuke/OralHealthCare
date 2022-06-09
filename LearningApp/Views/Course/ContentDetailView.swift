//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/3/29.
//

import SwiftUI


struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        GeometryReader { geo in
            
            if model.currentLesson != nil {
                
                VStack {
                    
                    YTVideoView(videoUrl: model.currentLesson!.video)
                        .frame(width: geo.size.width, height: geo.size.width/16*9)
                    
                    // Description
                    //CodeTextView()
                    Text(model.currentLesson!.explanation)
                    
                    // Next lesson button
                    if model.hasNextLesson() {
                        
                        Button {
                            //Advance the lesson
                            model.nextLesson()
                            
                        } label: {
                            ZStack {
                                RectangleCard(color: Color.green, height: 48)
                                Text("下一單元: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                                    .bold()
                                    .foregroundColor(.white)
                            }
                        }

                    }
                    else {
                        Button {
                            // Send the user back to HomeView
                            model.currentContentSelected = nil
                            model.currentLesson = nil
                            
                        } label: {
                            ZStack {
                                RectangleCard(color: Color.green, height: 48)
                                Text("完成")
                                    .bold()
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                
            }
            
            else {
                ProgressView()
            }
        }.padding(.horizontal)
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
            .environmentObject(ContentModel())
    }
}
