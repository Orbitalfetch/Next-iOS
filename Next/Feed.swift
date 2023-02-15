//
//  Feed.swift
//  Next
//
//  Created by Constantin Clerc on 05/02/2023.
//

import SwiftUI

struct Feed: View {
    @State private var animateGradient = false
    @State private var stage: String = ""
    @State private var showAlert = false
    @State private var showAlerted = false
    @State private var serialnb = UserDefaults.standard.string(forKey: "serialNumber")
    var body: some View {
        NavigationView {
            VStack{
                ZStack{
                    LinearGradient(colors: [.purple, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
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
                        
                        Button(action: {
                            self.stage
                        }) {
                            Text("Save")
                        }
                        Button(action: {
                            if let post = URL(string: "https://next.c22code.repl.co") {
                                let task = URLSession.shared.dataTask(with: post) {(data, response, error) in
                                    guard let data = data else { return }
                                    if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                                        do {
                                            // JSON String convertion
                                            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                                            let jsonString = String(data: jsonData, encoding: .utf8)
            //                              UIApplication.shared.alert(title:"Fetched json", body:jsonString!)
                                        } catch {
                                            UIApplication.shared.alert(title:"Error !", body: "Error while converting JSON to string...")
                                        }
                                        let someArray = json[stage] as? [[String: Any]]
                                        let someDict = someArray?.first
                                        if let title = someDict?["title"] as? String {
                                            if let body = someDict?["body"] as? String {
                                                if let key = someDict?["key"] as? Int {
                                                    showMe(title: title, body: body, key: key)
                                                }
                                            }
                                        }
                                    }
                                }
                                task.resume()
                            }
                        }) {
                            Text("Reloop")
                        }
                    }
                }
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
                                    UIApplication.shared.alert(title:"Device ID", body:"If developers ask for it, here is your device ID : \(String(describing: serialnb)) - It was pasted to clipboard")
                                }
                            )
                        )
                    }
                }
            }
            .onAppear{
                if let post = URL(string: "https://next.c22code.repl.co") {
                    let task = URLSession.shared.dataTask(with: post) {(data, response, error) in
                        guard let data = data else { return }
                        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                            do {
                                // JSON String convertion
                                let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                                let jsonString = String(data: jsonData, encoding: .utf8)
//                              UIApplication.shared.alert(title:"Fetched json", body:jsonString!)
                            } catch {
                                UIApplication.shared.alert(title:"Error !", body: "Error while converting JSON to string...")
                            }
                            let someArray = json[stage] as? [[String: Any]]
                            let someDict = someArray?.first
                            if let title = someDict?["title"] as? String {
                                if let body = someDict?["body"] as? String {
                                    if let key = someDict?["key"] as? Int {
                                        showMe(title: title, body: body, key: key)
                                    }
                                }
                            }
                        }
                    }
                    task.resume()
                }
            }
        }
    }
}
func showMe(title: String, body: String, key: Int) {
    UIApplication.shared.postAlert(title: title,body: body, onOK: {
        showMe(title:"Wow...", body:"It looks like you nexted to the bottom and that we do not have anything to show you anymore. Try refreshing the app !", key:0)
    }, infoAbt: {
        
    }, noCancel: false, key: 1)
}
struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}
