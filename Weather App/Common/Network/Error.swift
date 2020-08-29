//
//  Error.swift
//  Weather App
//
//  Created by Admin on 21/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

enum ResponseError: Error, CustomStringConvertible {
    case invalidURL, parsingError, requestFailed, networkError(code: Int), undefined
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL. Try again"
        case .parsingError:
            return "Failed to decode Data. Try again"
        case .requestFailed:
            return "Request failer, please try again."
        case .networkError(let code):
            return "Network error with code \(code). Try again"
        default:
            return "Some error has occured, please try again leter."
        }
    }
}
