//
//  SN.swift
//  Next
//
//  Created by Constantin Clerc on 14/02/2023.
//

import Foundation
import CryptoSwift
import UIKit

func storeSN() {
    let device = UIDevice.current
    let serialNumber = device.identifierForVendor?.uuidString ?? "N/A"
    if let aes = try? AES(key: "eT3gYTFd2WMsqOuMBk9YECXnkf3xGWUZ", iv: "53D315AEAE1586962E7E53A2D9FE7"),
       let aesE = try? aes.encrypt(Array(serialNumber.utf8)) {
        UserDefaults.standard.set(aesE, forKey: "serialNumber")
        // Place decryption here
    }
}

