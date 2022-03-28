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
        NavigationView {
            VStack(alignment: .leading) {
                Text("What do you want to do today?")
                    .padding(.leading, 20)
                ScrollView {
                    
                    LazyVStack {
                        ForEach(model.modules) { module in
                            
                            NavigationLink {
                                ContentView()
                                    .onAppear(perform: {
                                        model.beginModule(id: module.id)
                                    })
                            } label: {
                                HomeViewRow(title: "Learn \(module.category)", image: module.content.image, description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                            }
                            
                            HomeViewRow(title: "\(module.category) Test", image: module.test.image, description: module.test.description, count: "\(module.test.questions.count) Questions", time: module.test.time)
                        }
                    }
                    .padding()
                    .accentColor(.black)
                }
            }
            .navigationTitle("Get Started")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
