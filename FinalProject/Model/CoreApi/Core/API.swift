//
//  API.swift
//  FinalProject
//
//  Created by PCI0010 on 9/24/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation

// Defines
enum APIError: Error {
    case error(String)
    case errorURL
    case errorDataFormat

    var localizedDescription: String {
        switch self {
        case .error(let string):
            return string
        case .errorURL:
            return "URL String is error."
        case .errorDataFormat:
            return "Data format is error."
        }
    }
}

typealias APICompletion<T> = (Result<T, APIError>) -> Void

enum APIResult {
    case success(Data?)
    case failure(APIError)
}

struct API {
    // singleton
    private static var shareAPI: API = {
        let shareAPI = API()
        return shareAPI
    }()

    static func shared() -> API {
        return shareAPI
    }

    //init
    private init() {}
}
