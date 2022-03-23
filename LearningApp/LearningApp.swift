//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/3/24.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
