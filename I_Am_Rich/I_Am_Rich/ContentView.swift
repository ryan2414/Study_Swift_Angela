//
//  ContentView.swift
//  I_Am_Rich
//
//  Created by 이승재 on 2023/07/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            Color(uiColor: .systemTeal)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("I Am Rich")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                .foregroundColor(Color.white)
                
                Image("diamond")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200, alignment: .center)
            }
        }
     
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()//.previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))//해당 모델로 변경
    }
}
