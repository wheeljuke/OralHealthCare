//
//  HomeViewRow.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/3/25.
//

import SwiftUI

struct HomeViewRow: View {
    
    var title: String
    var image: String
    var description: String
    var count: String
    var time: String
    
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            
            HStack {
                
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(title)
                        .bold()
                    
                    Text(description)
                        .font(.caption)
                    
                    HStack {
                        
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(count)
                            .frame(width: 70, height: 15, alignment: .leading)
                            .font(Font.system(size: 10))
                        
                        Spacer()
                        
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(time)
                            .frame(width: 50, height: 15, alignment: .leading)
                            .font(Font.system(size: 10))
                        
                    }
                    
                }
                .padding(.leading, 20)
            }
            .padding(.horizontal)
            
        }
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(title: "Learn Swift", image: "swift", description: "learn more more", count: "10 Lessons", time: "3 Hours")
    }
}
