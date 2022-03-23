//
//  ContentView.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/3/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
