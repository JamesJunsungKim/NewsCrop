//
//  APIServiceError.swift
//  NewsCorp
//
//  Created by James Kim on 11/25/23.
//

import Foundation

enum APIServiceError: Error {
    case responseError
    case parseError(Error)
}
