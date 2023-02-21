//
//  Extensions.swift
//  Next
//
//  Created by Constantin Clerc on 12/02/2023.
//

import Foundation
import UIKit

var currentUIAlertController: UIAlertController?

extension UIApplication {
    func dismissAlert(animated: Bool) {
        DispatchQueue.main.async {
            currentUIAlertController?.dismiss(animated: animated)
        }
    }
    
    //stage
    func newStageAlert(sampletext: String) {
        let alertController = UIAlertController(title: "Enter stage name", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "stage (no caps)"
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            if let text = alertController.textFields?.first?.text {
                newStage(stagee: text)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alert: alertController)
    }
    
    // post start
    func newPostAlert(sampletext: String) {
        let alertController = UIAlertController(title: "Enter the stage", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "stage (no caps)"
        }
        let okAction = UIAlertAction(title: "Next", style: .default) { (action) in
            if let text = alertController.textFields?.first?.text {
                self.TitlenewStageAlert(stagee: text)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alert: alertController)
    }
    func TitlenewStageAlert(stagee: String) {
        let alertController = UIAlertController(title: "Enter the title", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Title..."
        }
        let okAction = UIAlertAction(title: "Next", style: .default) { (action) in
            if let text = alertController.textFields?.first?.text {
                self.BodynewStageAlert(stageee: stagee, titlee: text)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alert: alertController)
    }
    func BodynewStageAlert(stageee: String, titlee: String) {
        let alertController = UIAlertController(title: "Enter the post", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Content..."
        }
        let okAction = UIAlertAction(title: "Post !", style: .default) { (action) in
            if let text = alertController.textFields?.first?.text {
                post(titlee: titlee, bodyy: text, stagee: stageee)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alert: alertController)
    }
    // post end
    
    func alert(title: String = "Error", body: String, animated: Bool = true, withButton: Bool = true) {
        DispatchQueue.main.async {
            currentUIAlertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
            if withButton { currentUIAlertController?.addAction(.init(title: "OK", style: .cancel)) }
            self.present(alert: currentUIAlertController!)
        }
    }
    func postAlert(title: String = "Error", body: String, onOK: @escaping () -> (), infoAbt: @escaping () -> (), noCancel: Bool, key: Int) {
        DispatchQueue.main.async {
            currentUIAlertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
            if !noCancel {
                currentUIAlertController?.addAction(.init(title: "Out", style: .cancel))
            }
            currentUIAlertController?.addAction(.init(title: "Next", style: noCancel ? .cancel : .default, handler: { _ in
                onOK()
            }))
//            currentUIAlertController?.addAction(.init(title: "Info", style: noCancel ? .cancel : .default, handler: { _ in
//                infoAbt()
//            }))
//            currentUIAlertController?.addAction(.init(title: "Like", style: noCancel ? .cancel : .default, handler: { _ in
//                print("Liked", key)
//                onOK()
//            }))
            self.present(alert: currentUIAlertController!)
        }
    }
    func postInfo(title: String = "Error", body: String, onOK: @escaping () -> (), infoAbt: @escaping () -> (), noCancel: Bool) {
        DispatchQueue.main.async {
            currentUIAlertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
            if !noCancel {
                currentUIAlertController?.addAction(.init(title: "Cancel", style: .cancel))
            }
            currentUIAlertController?.addAction(.init(title: "Join", style: noCancel ? .cancel : .default, handler: { _ in
                infoAbt()
            }))
            currentUIAlertController?.addAction(.init(title: "Subscribe", style: noCancel ? .cancel : .default, handler: { _ in
                onOK()
            }))
            self.present(alert: currentUIAlertController!)
        }
    }
    func change(title: String = "Error", body: String) {
        DispatchQueue.main.async {
            currentUIAlertController?.title = title
            currentUIAlertController?.message = body
        }
    }
    
    func present(alert: UIAlertController) {
        if var topController = self.windows[0].rootViewController {
            
            topController.present(alert, animated: true)
            // topController should now be your topmost view controller
        }
    }
}

// fetch post start
func loopAlertFetch(stagee: String, laindex: Int){
    let url = URL(string: "https://next.c22code.repl.co/api")!
    let arrayName = stagee
    var lastIndex = laindex
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                if let array = json[arrayName] as? [[String: Any]], array.count > 0 {
                    for index in (lastIndex..<array.count).reversed() {
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
    }.resume()

}

// alert
func showMe(title: String, body: String, key: Int, stageee: String) {
    UIApplication.shared.postAlert(title: title,body: body, onOK: {
        loopAlertFetch(stagee: stageee, laindex: key)
    }, infoAbt: {
        
    }, noCancel: false, key: 1)
}

// fetch post end
