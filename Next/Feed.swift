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
                            print("The stage is: \(self.stage)")
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
                                            print("Error converting JSON data to string")
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
                                print("Error converting JSON data to string")
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
