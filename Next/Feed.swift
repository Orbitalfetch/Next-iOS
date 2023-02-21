//
//  Feed.swift
//  Next
//
//  Created by Constantin Clerc on 05/02/2023.
//

import SwiftUI
import UIKit

struct Feed: View {
    @State private var text = ""
    @State private var stage: String = ""
    @State private var showAlert = false
    @State private var serialnb = UserDefaults.standard.string(forKey: "serialEncrypted")
    var body: some View {
        NavigationView {
            VStack {
            }
            
            .onAppear {
                let alertController = UIAlertController(title: "Enter the stage", message: nil, preferredStyle: .alert)
                
                alertController.addTextField { textField in
                    textField.placeholder = "stage (no capitals)"
                }
                
                let okAction = UIAlertAction(title: "Go !", style: .default) { _ in
                    guard let textField = alertController.textFields?.first,
                          let text = textField.text else { return }
                    self.text = text
                    loopAlertFetch(stagee: text, laindex: 0)
                }
                
                let cancelAction = UIAlertAction(title: "Out", style: .cancel, handler: nil)
                
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                
                guard let viewController = UIApplication.shared.windows.first?.rootViewController else { return }
                viewController.present(alertController, animated: true, completion: nil)
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Next")
                        .bold()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("i")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 27, height: 27)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAlert.toggle()
                    }) {
                        Image(systemName: "info.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Welcome to our app !"),
                            message: Text("The client is fully free and almost all open source, so you can check out the code ! The app was made by c22dev, and the whole API server was made by boredcoder411 (we worked together during the project). Even if the app is certified as anonymous, some data may be saved for moderation purpose. You could see more info by clicking Open."),
                            primaryButton: .default(
                                Text("Open"),
                                action: {
                                    UIApplication.shared.open(URL(string: "https://info-next.c22code.repl.co/")!)
                                }
                            ),
                            secondaryButton: .default(
                                Text("ID"),
                                action: {
                                    UIPasteboard.general.string = serialnb
                                    UIApplication.shared.alert(title:"Device ID", body:"If developers ask for it, here is your device ID : \(serialnb ?? "none") - It was pasted to clipboard")
                                }
                            )
                        )
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        let alertController = UIAlertController(title: "Enter the stage", message: nil, preferredStyle: .alert)
                        
                        alertController.addTextField { textField in
                            textField.placeholder = "stage (no capitals)"
                        }
                        
                        let okAction = UIAlertAction(title: "Go !", style: .default) { _ in
                            guard let textField = alertController.textFields?.first,
                                  let text = textField.text else { return }
                            self.text = text
                            loopAlertFetch(stagee: text, laindex: 0)
                        }
                        
                        let cancelAction = UIAlertAction(title: "Out", style: .cancel, handler: nil)
                        
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        
                        guard let viewController = UIApplication.shared.windows.first?.rootViewController else { return }
                        viewController.present(alertController, animated: true, completion: nil)
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}
