//
//  StartUpView.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/5/23.
//

import SwiftUI

struct StartUpView: View {
    var body: some View {
        TabView {
            CalendarView()
                .tabItem {
                    VStack(alignment: .center) {
                        Image(systemName: "calendar.circle.fill")
                        Text("日曆")
                    }
                }
            HomeView()
                .tabItem {
                    VStack(alignment: .center) {
                        Image(systemName: "graduationcap.circle.fill")
                        Text("學習")
                    }
                }
            MapView()
                .tabItem {
                    VStack(alignment: .center) {
                        Image(systemName: "map.circle.fill")
                        Text("牙醫地圖")
                    }
                }
        }
    }
}

struct StartUpView_Previews: PreviewProvider {
    static var previews: some View {
        StartUpView()
    }
}
