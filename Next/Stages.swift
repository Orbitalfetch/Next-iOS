//
//  Stages.swift
//  Next
//
//  Created by Constantin Clerc on 05/02/2023.
//

import SwiftUI
import UIKit

struct Stages: View {
    @State private var animateGradient = false
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    LinearGradient(colors: [.green, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .hueRotation(.degrees(animateGradient ? 45 : 0))
                        .ignoresSafeArea()
                        .onAppear {
                            withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
                                animateGradient.toggle()
                            }
                        }
            }
                VStack {
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            UIApplication.shared.newStageAlert(sampletext: "")
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                        }
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
