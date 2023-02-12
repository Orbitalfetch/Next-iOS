//
//  Feed.swift
//  Next
//
//  Created by Constantin Clerc on 05/02/2023.
//

import SwiftUI

struct Feed: View {
    @State private var animateGradient = false
    var body: some View {
        NavigationView {
            VStack{
                LinearGradient(colors: [.purple, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .hueRotation(.degrees(animateGradient ? 45 : 0))
                    .ignoresSafeArea()
                    .onAppear {
                        withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
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
                if let post = URL(string: "https://gist.githubusercontent.com/c22dev/00d143ad043c5a0f3a60125f046ca310/raw/8f307185970a4a04210a80f523699ac7d6160be9/idk.json") {
                    let task = URLSession.shared.dataTask(with: post) {(data, response, error) in
                        guard let data = data else { return }
                        print("got that rizzz")
                        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                            if let title = json["title"] as? String {
                                print(title)
                                if let body = json["body"] as? String {
                                    if let key = json["key"] as? Int {
                                        showMe(title: title, body: body, key: key)
                                    }
                                }
                            }
                        }
                    }
                    task.resume()
                }
                
                
//                showMe(title:"I ate my dog.", body:"I don't know what happenned. Yesterday evening, I was pretty hungry. I decided to pick up my phone to look at Uber Eats. The servers were down (stupid ass uber eats)... I then tried to call the sushi restaurant next to my house, but they answered in Japenese so I didn't knew what to reply back. I was so desesperate, knowing I have no car, I couldn't move to a restaurant. My fridge was empty, and public transport were closed. So I had no choice. I saw my dog next to me, and did like what a good chinese citizen would have done ; I ate my dog. I took it with my 2 hands, and just dropped it in my hoven. I waited for 45 minutes, and it was ready. It tasted like chicken.", key:0)
            }
        }
    }
}
func showMe(title: String, body: String, key: Int) {
    UIApplication.shared.postAlert(title: title,body: body, onOK: {
        showMe(title:"", body:"", key:0)
    }, infoAbt: {
        
    }, noCancel: false, key: 1)
}
struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}
