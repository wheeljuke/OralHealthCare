//
//  CalendarView.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/5/23.
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                HStack {
                    
                    Spacer()

                    NavigationLink {
                        CalendarDetailView()
                    } label: {
                        HStack {
                            Text("新增紀錄")
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                    .padding(.horizontal)
                }
                
                ScrollView {
                    
                    ForEach(model.records) { r in
                        CalendarCard(date: r.date, duration: r.duration)
                            .frame(height: 60)
                            .padding(.horizontal)
                    }
                }
                
                
                
            }
           
            .navigationTitle("潔牙日曆")
        }
    }
}


struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(ContentModel())
    }
}

