//
//  Stages.swift
//  Next
//
//  Created by Constantin Clerc on 05/02/2023.
//

import SwiftUI
import UIKit
var stageKey = "idk"
struct Stages: View {
    @State private var animateGradient = false
    var body: some View {
        NavigationView {
            VStack{
//                Section(header: Text("Settings"), footer: Text("This will set your feed to this stage. You could change at anytime.")) {
//                    Button("Select a new stage") {
//                        .alert(isPresented: true) {
//                            Alert(
//                                title: Text("Goodbye..."),
//                                message: Text("The text at the top of settings was annoying, that's true... Please respring"),
//                                showInputDialog(title: "Add number",
//                                                subtitle: "Please enter the new number below.",
//                                                actionTitle: "Add",
//                                                cancelTitle: "Cancel",
//                                                inputPlaceholder: "New number",
//                                                inputKeyboardType: .numberPad, actionHandler:
//                                                        { (input:String?) in
//                                                            print("The new number is \(input ?? "")")
//                                                        }),
//                                secondaryButton: .default(
//                                    Text("OK")
//                                )
//                            )
//                        }
//                    }
//                }
                LinearGradient(colors: [.red, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .hueRotation(.degrees(animateGradient ? 45 : 0))
                    .ignoresSafeArea()
                    .onAppear {
                        withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                    }
            }
        }
    }
}

struct Stages_Previews: PreviewProvider {
    static var previews: some View {
        Stages()
    }
}
