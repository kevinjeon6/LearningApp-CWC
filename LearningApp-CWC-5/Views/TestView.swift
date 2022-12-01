//
//  TestView.swift
//  LearningApp-CWC-5
//
//  Created by Kevin Mattocks on 11/30/22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentViewModel
    
    var body: some View {
        if model.currentQuestion != nil {
            VStack {
                //Question number. We add one because the index starts at 0 but we dont want to display 0 of 10 for the first question
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                //Question
                CodeTextView()
                //Answers
                
                //Button
                
                
                //
            }
            .navigationTitle("\(model.currentModule?.category ?? "") Test")
        }
        else {
            //Test hasn't loaded yet
            ProgressView()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
