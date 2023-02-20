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
        alertController.addAction(okAction)
        present(alert: alertController)
    }
    
    func setStageAlert(sampletext: String) -> String {
        var stageName = ""
        
        let alertController = UIAlertController(title: "Enter stage name", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "stage (no caps)"
        }
        
        let okAction = UIAlertAction(title: "Set", style: .default) { (action) in
            if let text = alertController.textFields?.first?.text {
                stageName = text
            }
        }
        alertController.addAction(okAction)
        present(alert: alertController)
        while stageName.isEmpty {
        }
        return stageName
    }

    
    
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
