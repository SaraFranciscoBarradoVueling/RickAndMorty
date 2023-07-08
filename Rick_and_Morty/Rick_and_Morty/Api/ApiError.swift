//
//  ApiError.swift
//  Rick_and_Morty
//
//  Created by Sara Francisco on 8/7/23.
//

import Foundation

enum ApiError: Error {
    case decodingError
    case httpError(Int)
    case unknown
}
