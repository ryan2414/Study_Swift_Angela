//
//  ContentView.swift
//  JerryCard
//
//  Created by 이승재 on 2023/07/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.61, green: 0.53, blue: 1.00)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("jerry")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150.0, height: 150.0)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 5)
                    )
                
                Text("Jerry Lee")
                    .font(.custom("VT323", size: 45))
                    .foregroundColor(Color.white)
                Text("iOS Developer")
                    .foregroundColor(Color.white)
                    .font(.system(size: 25))
                Divider()
                InfoView(text: "js6270@naver.com", imageName: "envelope.fill")
                InfoView(text: "https://github.com/ryan2414", imageName: "link.circle.fill")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
