//
//  ContentLessonViewRow.swift
//  LearningApp-CWC-5
//
//  Created by Kevin Mattocks on 11/16/22.
//

import SwiftUI

struct ContentLessonViewRow: View {
    
    @EnvironmentObject var model: ContentViewModel
    var lessonIndex: Int
    
    
    var body: some View {
        let lesson = model.currentModule!.content.lessons[lessonIndex]
        
        //Lesson card
        
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(height: 66)
            
            HStack(spacing: 30) {
                
                Text(String(lessonIndex + 1))
                    .bold()
                
                VStack(alignment: .leading) {
                    Text(lesson.title)
                        .bold()
                    Text(lesson.duration)
                }
            }
            .padding()
        }//Zstack
        .padding(.bottom, 5)
    }
}

