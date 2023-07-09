//
//  ApiConfigurationProtocol.swift
//  Rick_and_Morty
//
//  Created by Sara Francisco on 8/7/23.
//

import Foundation

protocol ApiConfigurationProtocol {

    var path: String { get }
    var method: ApiMethod { get }
    var request: URLRequest { get }

}
