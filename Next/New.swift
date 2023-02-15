//
//  New.swift
//  Next
//
//  Created by Constantin Clerc on 05/02/2023.
//

import SwiftUI

struct New: View {
    @State private var customtitle: String = ""
    @State private var customdesc: String = ""
    @State private var stage: String = ""
    @State private var animateGradient = false
    var body: some View {
        VStack{
            ZStack{
                LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .hueRotation(.degrees(animateGradient ? 45 : 0))
                    .ignoresSafeArea()
                    .onAppear {
                        withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                    }
                
                VStack {
                    TextField(" stage (no capitals)", text: $stage)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(7)
                        .padding()
                        .frame(width: 200)
                    TextField("Title", text: $customtitle)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(7)
                        .padding()
                        .frame(width: 200)
                    TextField("Post", text: $customdesc)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(7)
                        .padding()
                        .frame(width: 200)
                    
                    Button(action: {
                        self.customtitle
                        self.customdesc
                        post(titlee: customtitle, bodyy: customdesc, stagee: stage)
                    }) {
                        Text("Post")
                    }
                }
            }
        }
    }
}

struct New_Previews: PreviewProvider {
    static var previews: some View {
        New()
    }
}
