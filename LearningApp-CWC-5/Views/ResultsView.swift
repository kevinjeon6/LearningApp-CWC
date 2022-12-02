//
//  ResultsView.swift
//  LearningApp-CWC-5
//
//  Created by Kevin Mattocks on 12/2/22.
//

import SwiftUI

struct ResultsView: View {
    
    @EnvironmentObject var model: ContentViewModel
    
    var numCorrect: Int
    
    var resultText: String {
        if numCorrect >= 8 {
            return "You're doing awesome"
        } else if numCorrect >= 6 {
            return " You're doing good!"
        } else {
            return "Keep learning and practicing!"
        }
    }
    
    
    var body: some View {
        
        
        VStack {
            Spacer()
            Text(resultText)
                .font(.title)
            Spacer()
            Text("You got \(numCorrect) out \(model.currentModule?.test.questions.count ?? 0) questions")
            
            Spacer()
            //MARK: - Button
            Button {
               //Send the user back to the HomeView
                model.currentTestSelected = nil
            } label: {
                ZStack {
                    RectangleCardView(color: .green)
                        .frame(height: 48)
                    Text("Complete")
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal)
            Spacer()

        }
    }
}

