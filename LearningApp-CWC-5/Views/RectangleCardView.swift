//
//  RectangleCardView.swift
//  LearningApp-CWC-5
//
//  Created by Kevin Mattocks on 11/28/22.
//

import SwiftUI

struct RectangleCardView: View {
    
    var color = Color.white
    
    var body: some View {
        Rectangle()
            .frame(height: 48)
            .foregroundColor(color)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct RectangleCardView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCardView()
    }
}
