//
//  PostSystem.swift
//  Next
//
//  Created by Constantin Clerc on 13/02/2023.
//
// How will this work ? An http post request

import Foundation
import UIKit
import SwiftUI


func post(titlee: String, bodyy: String, stagee: String) {
    let serialnb = UserDefaults.standard.string(forKey: "serialNumber")
    guard let url = URL(string: "https://next.c22code.repl.co") else {
        return
    }

    let data = ["title": titlee,
                "body": bodyy,
                "stage": stagee,
                "id": serialnb ]

    let jsonData = try! JSONSerialization.data(withJSONObject: data)

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            UIApplication.shared.alert(title:"An error occured", body: "\(error)")
            return
        }
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            UIApplication.shared.alert(title: "Error", body: "\(String(describing: response))")
            return
        }
        guard let data = data, let message = String(data: data, encoding: .utf8) else {
            UIApplication.shared.alert(title:"Invalid data", body: "You probably tried to send something else than a string. Please note it's not normal, report this error message.")
            return
        }
    }

    task.resume()
    UIApplication.shared.alert(title:"Posted !", body:"Your post was posted in \(stagee).")
}

func newStage(stagee: String) {
    guard let url = URL(string: "https://next.c22code.repl.co/newStage") else {
        return
    }

    let data = ["stage": stagee]

    let jsonData = try! JSONSerialization.data(withJSONObject: data)

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            UIApplication.shared.alert(title:"An error occured", body: "\(error)")
            return
        }
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            UIApplication.shared.alert(title: "Invalid response", body: "\(String(describing: response))")
            return
        }
        guard let data = data, let message = String(data: data, encoding: .utf8) else {
            UIApplication.shared.alert(title:"Invalid data", body: "You probably tried to send something else than a string. Please note it's not normal, report this error message.")
            return
        }
        print("Server returned \(message)")
    }

    task.resume()
    UIApplication.shared.alert(title:"Posted !", body:"The stage \(stagee) was created !")

}

extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed: CharacterSet = .urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

struct ResponseObject<T: Decodable>: Decodable {
    let form: T    // often the top level key is `data`, but in the case of https://httpbin.org, it echos the submission under the key `form`
}

struct Foo: Decodable {
    let id: String
    let name: String
}
