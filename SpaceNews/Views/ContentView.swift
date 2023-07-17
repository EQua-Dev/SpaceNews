//
//  ContentView.swift
//  SpaceNews
//
//  Created by Richard Uzor on 17/07/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var data = SpaceApi()
    @State private var opac = 0.0
    
    var body: some View {
        NavigationView{
            VStack {
                NewsView()
                    .opacity(opac)
                
            }.navigationTitle("Space News")
                .environmentObject(data)
                .onAppear{
                    data.getData()
                    
                    //set an animation to fade in the view after 2 seconds
                    withAnimation(.easeIn(duration: 2)){
                        opac = 1.0
                    }
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
