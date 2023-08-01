//
//  SN.swift
//  Next
//
//  Created by Constantin Clerc on 14/02/2023.
//

import Foundation
import CommonCrypto
import UIKit

func storeSN() {
    let device = UIDevice.current
    let serialNumber = device.identifierForVendor?.uuidString ?? "N/A"
    let stringToEncrypt = serialNumber
    let key = "?"
    if let encryptedString = encryptString(stringToEncrypt: stringToEncrypt, key: key) {
        UserDefaults.standard.set(encryptedString, forKey: "serialNumber")
    } else {
        UIApplication.shared.alert(title:"The encryption failed", body:"Maybe the serial isn't fetchable")
    }
}

func encryptString(stringToEncrypt: String, key: String) -> String? {
    let dataToEncrypt = stringToEncrypt.data(using: .utf8)
    let keyData = key.data(using: .utf8)

    let keyLength = kCCKeySizeAES256
    let encryptedData = NSMutableData(length: Int((dataToEncrypt?.count ?? 0)) + kCCBlockSizeAES128)

    let options = CCOptions(kCCOptionPKCS7Padding)
    var numBytesEncrypted: size_t = 0

    let cryptStatus = CCCrypt(
        CCOperation(kCCEncrypt),
        CCAlgorithm(kCCAlgorithmAES),
        options,
        (keyData! as NSData).bytes,
        keyLength,
        nil,
        (dataToEncrypt! as NSData).bytes,
        dataToEncrypt!.count,
        encryptedData!.mutableBytes,
        encryptedData!.length,
        &numBytesEncrypted
    )

    if Int32(cryptStatus) == Int32(kCCSuccess) {
        encryptedData!.length = Int(numBytesEncrypted)
        let encryptedString = encryptedData!.base64EncodedString()
        return encryptedString
    } else {
        return nil
    }
}

