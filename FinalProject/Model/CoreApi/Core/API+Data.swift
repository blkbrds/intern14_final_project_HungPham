//
//  API+Data.swift
//  FinalProject
//
//  Created by PCI0010 on 9/24/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
typealias JSON = [String: Any]
extension Data {
    func convertToJSON() -> [String: Any] {
        var json: [String: Any] = [:]
        do {
            if let jsonObj = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? [String: Any] {
                json = jsonObj
            }
        } catch {
            print("JSON casting error")
        }
        return json
    }
}
