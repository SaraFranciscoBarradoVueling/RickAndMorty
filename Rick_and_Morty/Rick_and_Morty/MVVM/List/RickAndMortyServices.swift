//
//  RickAndMortyServices.swift
//  Rick_and_Morty
//
//  Created by Sara Francisco on 8/7/23.
//

import Foundation
import Combine

protocol RickAndMortyServices {
    var apiSession: ApiProtocol { get }
    func getAllCharacters() -> AnyPublisher<Characters, ApiError>
}

extension RickAndMortyServices {

    func getAllCharacters() -> AnyPublisher<Characters, ApiError> {

        return apiSession.request(with: ApiEndpoint.getAllCharacters)

            .eraseToAnyPublisher()
    }

    func getNextPage(page: String) -> AnyPublisher<Characters, ApiError> {

        return apiSession.request(with: ApiEndpoint.getNextOrPrevPage(page: page))

            .eraseToAnyPublisher()
    }

    func getPrevPage(page: String) -> AnyPublisher<Characters, ApiError> {

        return apiSession.request(with: ApiEndpoint.getNextOrPrevPage(page: page))

            .eraseToAnyPublisher()
    }
}
