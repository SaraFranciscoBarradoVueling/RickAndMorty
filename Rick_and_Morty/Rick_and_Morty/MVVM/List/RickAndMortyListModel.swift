//
//  RickAndMortyListModel.swift
//  Rick_and_Morty
//
//  Created by Sara Francisco on 8/7/23.
//

import Foundation

enum CharacterViewModelState {
case initial
case loading
case loaded(characters:Characters)
case error(errorMessage:String)
}

struct Characters: Decodable {
    let info: Info
    let results: [Results]?

    enum CodingKeys: String, CodingKey {
        case info = "info"
        case results = "results"
    }
}

struct Info: Codable {
    let count: Int?//": 826,
    let pages: Int?//": 42,
    let next: String?//": "https://rickandmortyapi.com/api/character?page=2",
    let prev: String?//": null

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case pages = "pages"
        case next = "next"
        case prev = "prev"
    }
}

struct Results: Identifiable, Codable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case status = "status"
        case species = "species"
        case type = "type"
        case gender = "gender"
        case origin = "origin"
        case location = "location"
        case image = "image"
        case episode = "episode"
        case url = "url"
        case created = "created"
    }
}

struct Location: Codable {
    let name: String?//": "Citadel of Ricks",
    let url: String?//": "https://rickandmortyapi.com/api/location/3"

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
}
