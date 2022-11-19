//
//  ContentLessonView.swift
//  LearningApp-CWC-5
//
//  Created by Kevin Mattocks on 11/16/22.
//

import SwiftUI

struct ContentLessonView: View {
    
    @EnvironmentObject var model: ContentViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                
                //Confirm that currentModule is set
                
                if model.currentModule != nil {
                    ForEach(0..<model.currentModule!.content.lessons.count) {
                        lessonIndex in
                        NavigationLink {
                            ContentDetailView()
                                .onAppear {
                                    model.beginLesson(lessonIndex)
                                }
                        } label: {
                            ContentLessonViewRow(lessonIndex: lessonIndex)
                        }

                        
                   
                        
                    }
                }
                
               
            }
            .accentColor(.black)
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}

struct ContentLessonView_Previews: PreviewProvider {
    static var previews: some View {
        ContentLessonView()
    }
}
