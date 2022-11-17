//
//  ContentViewModel.swift
//  LearningApp-CWC-5
//
//  Created by Kevin Mattocks on 10/30/22.
//

import Foundation

//ObserableObject: UI can now observe the object for changes. The object created is ContentViewModel

class ContentViewModel: ObservableObject {
    
    //Storing our modules in. Module is an array since the JSON data is surrounded by square brackets. This will be a List of modules
    @Published var modules = [Module]()
    
    //Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0

    
    
    //Style property. Setting it to an optional Data object
    var styleData: Data?
    
    
    
    
    
    init() {
        getLocalData()
    }
    
    
    //MARK: - Data methods
    func getLocalData() {
        //Get URL to JSON file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        //Read the file into a data object
        do {
            
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            
            //Try to decode JSON into an array of modules
            let jsonDecoder = JSONDecoder()
            
            
           var modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            //Assign parsed modules to modules property
            self.modules = modules
            
        } catch {
            print("Couldn't parse local data")
        }
        
        //MARK: - Parse the style data
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
            
            
        } catch {
            print("Could not parse the style dta")
        }

    }
    
    
    
    //MARK: - Module navigation methods
    
    func beginModule(_ moduleid: Int) {
        //Find the index for this module id
        for index in 0..<modules.count {
            if modules[index].id == moduleid {
                
                //Found the matching module
                currentModuleIndex = index
                break
            }
        }
        
    
        
        //Set the current module
        currentModule = modules[currentModuleIndex]
    }
    
}
