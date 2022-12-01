//
//  TestView.swift
//  LearningApp-CWC-5
//
//  Created by Kevin Mattocks on 11/30/22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentViewModel
    @State var selectedAnswerIndex: Int?
    
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        if model.currentQuestion != nil {
            VStack (alignment: .leading) {
                //Question number. We add one because the index starts at 0 but we dont want to display 0 of 10 for the first question
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                //Question
                CodeTextView()
                    .padding(.horizontal, 20)
                //Answers
                ScrollView {
                    VStack {
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            
                                Button {
                                    //Track the selected answer index
                                    selectedAnswerIndex = index
                                } label: {
                                    
                                    ZStack {
                                        
                                        if submitted == false {
                                            RectangleCardView(color: index == selectedAnswerIndex ? .gray : .white)
                                                .frame(height: 48)
                                        } else {
                                            //Answer has been submitted
                                            if index == selectedAnswerIndex && index == model.currentQuestion?.correctIndex {
                                                //User selected the right answer
                                                //Show a green background
                                                RectangleCardView(color: .green)
                                                    .frame(height: 48)
                                            } else if index == selectedAnswerIndex && index != model.currentQuestion?.correctIndex {
                                                
                                                //User selected the wrong answer
                                                RectangleCardView(color: .red)
                                                    .frame(height: 48)
                                            } else if index == model.currentQuestion?.correctIndex {
                                                //This button is the correct ansswer
                                                RectangleCardView(color: .green)
                                                    .frame(height: 48)
                                            } else {
                                                RectangleCardView(color: .white)
                                                    .frame(height: 48)
                                            }
                                        }
                                        
                                        
                                        Text(model.currentQuestion!.answers[index])
                                    }
                                }//Button
                                .disabled(submitted)
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
                
                //Submit Button
                Button {
                    //Change submitted button to true
                    submitted = true
                    
                    //Check the answer and increment the counter if correct
                    if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                        numCorrect += 1
                    }
                } label: {
                    ZStack {
                        RectangleCardView(color: .green)
                        Text("Submit")
                            .bold()
                           
                            .foregroundColor(.white)
                        
                    }
                    .padding()
                }
                .disabled(selectedAnswerIndex == nil)
                //When the user hasn't selected an answer.

                
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
