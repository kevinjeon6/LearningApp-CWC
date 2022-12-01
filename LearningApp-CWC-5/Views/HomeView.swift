//
//  ContentView.swift
//  LearningApp-CWC-5
//
//  Created by Kevin Mattocks on 10/30/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentViewModel
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading) {
                Text("What do you want to do today?")
                    .padding(.leading, 20)
                
                ScrollView {
                    LazyVStack {
                        ForEach(model.modules) {
                            module in
                            
                            
                            VStack(spacing: 20) {
                                
                                
                                NavigationLink(destination: ContentLessonView()
                                    .onAppear(perform: {
                                    model.beginModule(module.id)
                                }),
                                    tag: module.id,
                                    selection: $model.currentContentSelected)
                                     {
                                    //MARK: - Learning Card
                                    HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                }
                                
                                NavigationLink(destination: TestView().onAppear(perform: {
                                        model.beginTest(module.id)
                                    }),
                                               tag: module.id,
                                               selection: $model.currentTestSelected) {
                                    //MARK: - Testing Card
                                    HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Lessons", time: module.test.time)
                                }
                                
                                
                                NavigationLink(destination: EmptyView()) {
                                    EmptyView()
                                }
                                
                            }
                            
                        }
                        
                    }
                    .accentColor(.black)
                    .padding()
                }
            }
            .navigationTitle("Get Started")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentViewModel())
    }
}
