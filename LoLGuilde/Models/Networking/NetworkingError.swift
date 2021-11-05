//
//  NetworkingError.swift
//  LoLGuilde
//  định nghĩa các error trong cả quá trình tương tác API
//
//  Created by Bang on 28/10/2021.
//

import Foundation

enum NetworkingError: Error {
    case invalidURL(String)
    case invalidParameter(String, Any)
    case invalidJSON(String)
    case invalidDecoderConfiguration
}
