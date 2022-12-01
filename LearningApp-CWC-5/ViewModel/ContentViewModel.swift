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
    
    //Current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    //Current Question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0

    
    
    //Current lesson explanation
    @Published var codeText = NSAttributedString()
    
    //Style property. Setting it to an optional Data object
    var styleData: Data?
    
    //Current selected content and test
    @Published var currentContentSelected: Int?
    @Published var currentTestSelected: Int?
    
    
    
    
    
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
    
    
    func beginLesson(_ lessonIndex: Int) {
        //Check that th lesson index is within range of the module lessons
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        } else {
            currentLessonIndex = 0
        }
        
        //Set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        codeText = addStyling(currentLesson!.explanation)
    }
    
    
    
    func hasNextLesson() -> Bool {
        return (currentLessonIndex + 1 < currentModule?.content.lessons.count ?? 0)
      
    }
    
    func beginTest(_ moduleId: Int) {
        //Set the current module
        beginModule(moduleId)
        //Set the current question
        currentQuestionIndex = 0
        
        //If there ar equestions, set the current question to the first one
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule?.test.questions[currentQuestionIndex]
            //Set the question content
            codeText = addStyling(currentQuestion!.content) 
        }
    }
    
    
    func nextLesson() {
        //Advance the lesson index
        
        currentLessonIndex += 1
        
        //Check that it is within range
        
        if currentLessonIndex < currentModule?.content.lessons.count ?? 0 {
            //Set the current lesson property
            currentLesson = currentModule?.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)
        } else {
            //Reset the lesson state
            currentLesson = nil
            currentLessonIndex = 0
        }
        
     
    }
    
    
    //MARK: - Code Styling
    
    private func addStyling (_ htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        //Add the styling data
        if styleData != nil {
            
            data.append(self.styleData!)
        }
        
        //Add the html data
        data.append(Data(htmlString.utf8))
        //Convert to attributed string
        
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                
                resultString = attributedString
            }
      
        return resultString
    }
}
