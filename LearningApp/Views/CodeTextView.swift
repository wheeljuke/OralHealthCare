//
//  CodeTextView.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/4/2.
//

import SwiftUI

struct CodeTextView: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    // creating an instance of the UITextView
    func makeUIView(context: Context) -> UITextView {
        
        let textView = UITextView()
        textView.isEditable = false
        
        return textView
    }
    
    // initing the UITextView
    func updateUIView(_ textView: UITextView, context: Context) {
        
        // set the attributed text for the lesson (init the description)
        textView.attributedText = model.lessonDescription
        // Scroll back to the top
        textView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
    }
}

struct CodeTextView_Previews: PreviewProvider {
    static var previews: some View {
        CodeTextView()
    }
}
