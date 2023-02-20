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
                            loopAlertFetch(stagee: stage, laindex: 0)
                        }) {
                            Text("Loop")
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

            }
        }
    }
}

func loopAlertFetch(stagee: String, laindex: Int){
    let url = URL(string: "https://next.c22code.repl.co/api")!
    let arrayName = stagee
    var lastIndex = laindex
    print("ID before fetching post\(lastIndex)")
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                if let array = json[arrayName] as? [[String: Any]], array.count > 0 {
                    for index in (lastIndex..<array.count).reversed() {
                        // Check if this object has already been shown
                        if index < lastIndex {
                            break
                        }
                        let object = array[lastIndex]
                        if let title = object["title"] as? String, let body = object["body"] as? String {
                            lastIndex = laindex + 1
                            showMe(title: title, body: body, key: lastIndex, stageee: stagee)
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        } else if let error = error {
            print(error.localizedDescription)
        }
        print("ID after fetching post\(lastIndex)")
    }.resume()

}
func showMe(title: String, body: String, key: Int, stageee: String) {
    print("ID after fetching func \(key)")
    UIApplication.shared.postAlert(title: title,body: body, onOK: {
        loopAlertFetch(stagee: stageee, laindex: key)
    }, infoAbt: {
        
    }, noCancel: false, key: 1)
}
struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}
