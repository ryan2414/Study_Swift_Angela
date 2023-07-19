//
//  InfoView.swift
//  JerryCard
//
//  Created by 이승재 on 2023/07/19.
//

import SwiftUI


struct InfoView: View {
    
    let text: String
    let imageName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.white)
            .frame(height: 50.0)
            .overlay(HStack {
                Image(systemName: imageName)
                    .foregroundColor(.purple)
                Text(text)
                    .foregroundColor(.black)
            })
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}


struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "Dummy", imageName: "envelope.fill")
            .previewLayout(.sizeThatFits)
    }
}
