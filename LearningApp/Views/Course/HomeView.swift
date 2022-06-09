//
//  ContentView.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/3/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        GeometryReader { geo in
            
            NavigationView {
                VStack(alignment: .leading) {
                    Text("今天想要學習什麼呢?")
                        .padding(.leading, 20)
                    ScrollView {
                        
                        LazyVStack {
                            ForEach(model.modules) { module in
                                
                                VStack(spacing: 20) {
                                    
                                    NavigationLink(
                                        tag: module.id,
                                        selection: $model.currentContentSelected) {
                                            
                                            ContentView()
                                                .onAppear(perform: {
                                                    model.beginModule(id: module.id)
                                                })
                                            
                                        } label: {
                                            
                                            HomeViewRow(title: "學習\(module.category)", image: module.content.image, description: module.content.description, count: "\(module.content.lessons.count) 影片", time: module.content.time)
                                            
                                        }
                                    
                                    NavigationLink(
                                        tag: module.id,
                                        selection: $model.currentTestSelected) {
                                            
                                            TestView()
                                                .onAppear(perform: {
                                                    model.beginTest(moduleId: module.id)
                                                })
                                            
                                        } label: {
                                            
                                            HomeViewRow(title: "\(module.category)小挑戰", image: module.test.image, description: module.test.description, count: "\(module.test.questions.count) 題目", time: module.test.time)
                                            
                                        }
                                }
                                .padding(.bottom, 12)
                                
                            }
                        }
                        .padding()
                        .accentColor(.black)
                    }
                }
                .navigationTitle("開始今天的口腔保健")
                .onChange(of: model.currentContentSelected) { newValue in
                    if newValue == nil {
                        model.currentModule = nil
                    }
                }
        
            }
            .frame(height: geo.size.height-5)
            .navigationViewStyle(.stack)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
