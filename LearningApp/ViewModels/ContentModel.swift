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
}

