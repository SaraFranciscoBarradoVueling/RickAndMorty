//
//  ApiEndpoint.swift
//  Rick_and_Morty
//
//  Created by Sara Francisco on 8/7/23.
//

import Foundation

internal enum ApiEndpoint {
    case getAllCharacters
    case getNextPage(page: String)
}

extension ApiEndpoint: ApiConfigurationProtocol {

    // MARK: - Constants
    private enum Constants {
        static let timeout: TimeInterval = 30
    }

    // MARK: - HTTPMethods
    var method: ApiMethod {
        switch self {
        default: return .GET
        }
    }

    // MARK: - Endpoints
    var path: String {
        switch self {
        case .getAllCharacters:
            return "character"
        case .getNextPage(let page):
            return "character/?page=" + page
        }
    }

    var request: URLRequest {
        var request: URLRequest
        guard var url = URL(string: "https://rickandmortyapi.com/api/\(path)") else {
            preconditionFailure("Invalid URL format")
        }
        request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        request.timeoutInterval = Constants.timeout
        return request
    }
}
