//
//  ContentModel.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/3/24.
//

import Foundation

class ContentModel: ObservableObject {
    
    // List of modules
    @Published var modules = [Module]()
    
    // Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    // Current Lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // Current lesson explanation
    @Published var lessonDescription = NSAttributedString()
    var styleData: Data?
    
    init() {
        
        getLocalData()
    }
    
    // MARK: - Data methods
    func getLocalData() {
        
        // MARK: Parse the jsonData
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            let jsonDecoder = JSONDecoder()
            
            do {
                
                let modules = try jsonDecoder.decode([Module].self, from: jsonData)
                
                self.modules = modules
            }
            
            catch {
                print("Can't Decode jsonData")
            }
        }
        catch {
            
            print("Error fetching the jsonData from URL")
        }
        
        // MARK: Parse the StyleData
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
        }
        
        catch {
            
            print("Error fetching the htmlData from URL")
        }
    }
    
    // MARK: - Module navigation methods
    func beginModule(id: Int) {
        
        // Find the index for this module id
        for index in 0..<modules.count {
            if modules[index].id == id {
                // Found the matching module
                currentModuleIndex = id
                break
            }
        }
        
        // Set the current module
        currentModule = modules[currentModuleIndex]
    }
    
    func beginLesson(lessonIndex: Int) {
        
        // Check if the lesson index is in the range of module lessons
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        }
        else {
            currentLessonIndex = 0
        }
        // Set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        lessonDescription = addStyling(htmlString: currentLesson!.explanation)
    }
    
    func nextLesson() {
        
        // Advance the lesson
        currentLessonIndex += 1
        
        // Check that it is within range
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            // Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            lessonDescription = addStyling(htmlString: currentLesson!.explanation)
        }
        else {
            currentLessonIndex = 0
            currentLesson = nil
            lessonDescription = NSAttributedString()
        }
    }
    
    func hasNextLesson() -> Bool {
        
        /*
         if currentLessonIndex + 1 < currentModule!.content.lessons.count {
         return true
         }
         else {
         return false
         }
         */
        return currentLessonIndex + 1 < currentModule!.content.lessons.count
    }
    
    private func addStyling(htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        // Add the styling data
        if styleData != nil {
            data.append(styleData!)
        }
        
        // Add the html data
        data.append(Data(htmlString.utf8))
        
        // Converting the html to NSAttributedString
        do {
            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            
            resultString = attributedString
            
        }
        catch {
            print("couldn't turn html into AttributedString")
        }
        
        /*
         Other Method :
         
         if let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            resultString = attributedString
         }
        
         this doesn't catch the error 
         */
        
        return resultString
    }
    
    
}

