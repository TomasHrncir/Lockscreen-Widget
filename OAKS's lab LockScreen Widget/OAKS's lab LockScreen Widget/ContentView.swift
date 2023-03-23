//
//  ContentView.swift
//  OAKS's lab LockScreen Widget
//
//  Created by Tom on 22.03.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.black)
            Image("text")
                .resizable()
                .scaledToFit()
        }
        .ignoresSafeArea()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
