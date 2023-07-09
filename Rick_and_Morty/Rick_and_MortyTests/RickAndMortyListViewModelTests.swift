//
//  RickAndMortyListViewModelTests.swift
//  Rick_and_MortyTests
//
//  Created by Sara Francisco on 9/7/23.
//

import XCTest
import Combine
@testable import Rick_and_Morty

class RickAndMortyListViewModelTests: XCTestCase {

    var viewModel: RickAndMortyListViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        viewModel = RickAndMortyListViewModel()
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testFilteredData() {
        let resultOne = Results(id: 1,
                                name: "Rick",
                                status: "Alive",
                                species: "Human",
                                type: "",
                                gender: "Male",
                                origin: Location(name: "origin",
                                                 url: ""),
                                location: Location(name: "location",
                                                   url: ""),
                                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                                episode: ["https://rickandmortyapi.com/api/episode/1"],
                                url: "https://rickandmortyapi.com/api/character/1",
                                created: "2017-11-04T18:48:46.250Z")
        let resultTwo = Results(id: 2,
                                name: "Morty",
                                status: "Alive",
                                species: "Human",
                                type: "",
                                gender: "Male",
                                origin: Location(name: "origin",
                                                 url: ""),
                                location: Location(name: "location",
                                                   url: ""),
                                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                                episode: ["https://rickandmortyapi.com/api/episode/1"],
                                url: "https://rickandmortyapi.com/api/character/1",
                                created: "2017-11-04T18:48:46.250Z")
    let characters = [resultOne, resultTwo]
    let searchText = "Rick"

    let filteredData = viewModel.filteredData(characters: characters, searchText: searchText)

    XCTAssertEqual(filteredData.count, 1)
    XCTAssertEqual(filteredData.first?.name, "Rick")
    XCTAssertEqual(filteredData.first?.status, "Alive")
}

func testGetAllCharacters() {
    let expectation = XCTestExpectation(description: "Get all characters expectation")

    viewModel.$charactersState
        .dropFirst()
    .sink { state in
        if case .loaded(let characters) = state {
            XCTAssertEqual(characters.results?.count, 20)
            expectation.fulfill()
        }
    }
        .store(in: &cancellables)

    viewModel.getAllCharacters()

    wait(for: [expectation], timeout: 5.0)
}

func testGetNext() {
    let expectation = XCTestExpectation(description: "Get next page expectation")

    viewModel.$charactersState
        .dropFirst()
    .sink { state in
        if case .loaded(let characters) = state {
            XCTAssertEqual(characters.results?.count, 20)
            expectation.fulfill()
        }
    }
        .store(in: &cancellables)

    viewModel.getNext()

    wait(for: [expectation], timeout: 5.0)
}

func testGetPrev() {
    let expectation = XCTestExpectation(description: "Get previous page expectation")

    viewModel.$charactersState
        .dropFirst()
    .sink { state in
        if case .loaded(let characters) = state {
            XCTAssertEqual(characters.results?.count, 20)
            expectation.fulfill()
        }
    }
        .store(in: &cancellables)

    viewModel.getPrev()

    wait(for: [expectation], timeout: 5.0) 
}
}
