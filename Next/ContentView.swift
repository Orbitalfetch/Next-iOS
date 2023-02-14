//
//  ContentView.swift
//  Next
//
//  Created by Constantin Clerc on 05/02/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Feed()
                .tabItem {
                    Label("Feed", systemImage: "house")
                }
            New()
                .tabItem {
                    Label("Add", systemImage: "plus")
                }
            Stages()
                .tabItem {
                    Label("Stages", systemImage: "person.2.crop.square.stack")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
