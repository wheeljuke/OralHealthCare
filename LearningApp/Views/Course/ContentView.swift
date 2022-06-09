//
//  ContentView.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/3/28.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        if model.currentModule != nil {
            
            ScrollView {
                
                LazyVStack {
                    
                    if model.currentModule != nil {
                        
                        ForEach(0..<model.currentModule!.content.lessons.count) { index in
                            NavigationLink {
                                ContentDetailView()
                                    .onAppear {
                                        model.beginLesson(lessonIndex: index)
                                    }
                            } label: {
                                ContentViewRow(index: index)
                            }

                            
                        }
                    }
                }
                .accentColor(.black)
                .padding()
                .navigationTitle("學習\(model.currentModule?.category ?? "")")
            }
        }
        
        else {
            ProgressView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ContentModel())
    }
}
