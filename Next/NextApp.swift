//
//  NextApp.swift
//  Next
//
//  Created by Constantin Clerc on 05/02/2023.
//

import SwiftUI

@main
struct NextApp: App {
    @State var blacklisted = false
    @State private var serialNb = "unknown"
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear{
                    storeSN()
                    checkBlacklist()
                }
        }
    }
}
