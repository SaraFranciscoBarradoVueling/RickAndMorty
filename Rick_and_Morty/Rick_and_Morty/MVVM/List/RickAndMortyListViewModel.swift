//
//  RickAndMortyListViewModel.swift
//  Rick_and_Morty
//
//  Created by Sara Francisco on 8/7/23.
//

import Foundation
import Combine


class RickAndMortyListViewModel: ObservableObject, RickAndMortyServices {
    var apiSession: ApiProtocol = Api()
    

    @Published var charactersState: CharacterViewModelState = CharacterViewModelState.initial

    var cancellable = Set<AnyCancellable>()


    init() {
        getAllCharacters()
    }

    func getAllCharacters() {
        charactersState = CharacterViewModelState.loading
        getAllCharacters()
            .sink { [weak self] completion in
            switch completion {

            case .finished:
                print("finish")
            case .failure(let error):
                self?.charactersState = CharacterViewModelState.error(errorMessage: "\(error)")
            }
        } receiveValue: { [weak self] Characters in
            self?.charactersState = CharacterViewModelState.loaded(characters: Characters)
        }
            .store(in: &cancellable)
    }

}
