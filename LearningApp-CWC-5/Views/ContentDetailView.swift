//
//  ContentDetailView.swift
//  LearningApp-CWC-5
//
//  Created by Kevin Mattocks on 11/17/22.
//
import AVKit
import SwiftUI


struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentViewModel
    

    
    var body: some View {
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack {
            //Only show video if we get a valid URL
            if url != nil {
                
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
                
            }
            
            //MARK: - Description
            CodeTextView()
            
            
            //MARK: - Next lesson button
            
            //SHow next lesson button ony if there is a next lesson
            if model.hasNextLesson() {
                Button {
                    //Advance the lesson
                    model.nextLesson()
                    
                } label: {
                    
                    ZStack {
                  
                        
                        
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(.white)
                            .bold()
                    }
                 
                }
            } else {
                //If it doesn't have a next lesson. Show a complete button
                Button {
                //Take the user back to homeView
                    model.currentContentSelected = nil
                    
                } label: {
                    
                    ZStack {
                        RectangleCardView(color: .green)
                        
                        
                        
                        Text("Complete")
                            .foregroundColor(.white)
                            .bold()
                    }
                 
                }
            }
           

        }
        .padding()
        .navigationTitle(lesson?.title ?? "")
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
