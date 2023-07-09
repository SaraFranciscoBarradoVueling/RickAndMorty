//
//  RickAndMortyListViewModel.swift
//  Rick_and_Morty
//
//  Created by Sara Francisco on 8/7/23.
//

import Foundation
import Combine
import SwiftUI

class RickAndMortyListViewModel: ObservableObject, RickAndMortyServices {
    var apiSession: ApiProtocol = Api()
    @Published var charactersState: CharacterViewModelState = CharacterViewModelState.initial
    var cancellable = Set<AnyCancellable>()
    @Published var actualPage = 0
    var nextPage = 0
    var prevPage = 0

    init() {
    }
    
    private func fetchData(page: Int?, completion: @escaping (Result<Characters, ApiError>) -> Void) {
        charactersState = CharacterViewModelState.loading
        var request: AnyPublisher<Characters, ApiError> = getAllCharacters()
        if let safepage = page {
            if safepage == nextPage {
                request = getNextPage(page: String(safepage))
            } else {
                request = getPrevPage(page: String(safepage))
            }
        }
        
        request
            .sink { [weak self] response in
                switch response {
                case .finished:
                    print("finish")
                case .failure(let error):
                    self?.charactersState = CharacterViewModelState.error(errorMessage: "\(error)")
                }
            } receiveValue: { [weak self] characters in
                self?.charactersState = CharacterViewModelState.loaded(characters: characters)
                if let next = characters.info.next, let queryRange = next.range(of: "?page=") {
                    self?.nextPage = Int(next[queryRange.upperBound...]) ?? 0
                }
                if let prev = characters.info.prev, let queryRange = prev.range(of: "?page=") {
                    self?.prevPage = Int(prev[queryRange.upperBound...]) ?? 0
                }
                self?.actualPage = (self?.nextPage ?? 0) - 1
                
                completion(.success(characters))
            }
            .store(in: &cancellable)
    }

    func getAllCharacters() {
        fetchData(page: nil) { result in
            switch result {
                
            case .success(_):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getNext() {
        fetchData(page: nextPage) { result in
            switch result {
                
            case .success(_):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getPrev() {
        fetchData(page: prevPage) { result in
            switch result {
                
            case .success(_):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func filteredData(characters: [Results], searchText: String)-> [Results] {
        var filteredData = [Results]()
        characters.forEach { item in
            if let name = item.name, name.lowercased().contains(searchText.lowercased()) {
                filteredData.append(item)
            }
        }
        return filteredData
    }
}
