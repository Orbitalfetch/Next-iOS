//
//  New.swift
//  Next
//
//  Created by Constantin Clerc on 05/02/2023.
//

import SwiftUI

struct New: View {
    var body: some View {
        NavigationView{
            VStack {
                
            }
            .onAppear {
                UIApplication.shared.newPostAlert(sampletext: "")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Post")
                        .bold()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        UIApplication.shared.newPostAlert(sampletext: "")
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

struct New_Previews: PreviewProvider {
    static var previews: some View {
        New()
    }
}
