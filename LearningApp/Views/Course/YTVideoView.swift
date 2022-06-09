//
//  YTVideoView.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/5/24.
//

import SwiftUI
import WebKit

struct YTVideoView: UIViewRepresentable {
    
    let videoUrl: String
    
    func makeUIView(context: Context) -> some WKWebView {
        
        return WKWebView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        let url = URL(string: videoUrl)
        
        if url != nil {
            
            uiView.scrollView.isScrollEnabled = false
            uiView.load(URLRequest(url: url!))
        }
        
        else {
            
            print("video Url invalid")
        }
    }
}
