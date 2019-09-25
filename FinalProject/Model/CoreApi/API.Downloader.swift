//
//  API.Downloader.swift
//  FinalProject
//
//  Created by PCI0010 on 9/24/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import UIKit

extension ApiManager.Downloader {
    static func downloadImage(imageURL: String, index: Int, completion: @escaping (UIImage?, Int) -> Void) {
        API.shared().request(urlString: imageURL) { (result) in
            switch result {
            case .failure(_):
                completion(nil, index)
            case .success(let data):
                if let data = data,
                    let image = UIImage(data: data) {
                    completion(image, index)
                } else {
                    completion(nil, index)
                }
            }
        }
    }
}
