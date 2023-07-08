//
//  ApiProtocol.swift
//  Rick_and_Morty
//
//  Created by Sara Francisco on 8/7/23.
//

import Combine

protocol ApiProtocol {
    func request<T: Decodable>(with builder: ApiConfigurationProtocol) -> AnyPublisher<T, ApiError>
}
