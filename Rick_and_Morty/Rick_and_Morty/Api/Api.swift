//
//  Api.swift
//  Rick_and_Morty
//
//  Created by Sara Francisco on 8/7/23.
//

import Foundation
import Combine

internal struct Api: ApiProtocol {
    func request<T: Decodable>(with builder: ApiConfigurationProtocol) -> AnyPublisher<T, ApiError> {

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return URLSession.shared
            .dataTaskPublisher(for: builder.request)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<T, ApiError> in
                if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {
                        return Just(data)
                            .decode(type: T.self, decoder: decoder)
                            .mapError { _ in .decodingError }
                            .eraseToAnyPublisher()
                    } else {
                        return Fail(error: .httpError(response.statusCode))
                            .eraseToAnyPublisher()
                    }
                }
                return Fail(error: .unknown)
                        .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
