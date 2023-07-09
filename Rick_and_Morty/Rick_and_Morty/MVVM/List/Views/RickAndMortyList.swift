//
//  ContentView.swift
//  Rick_and_Morty
//
//  Created by Sara Francisco on 8/7/23.
//

import SwiftUI
import CoreData

struct RickAndMortyList: View {
    @StateObject private var viewModel: RickAndMortyListViewModel = RickAndMortyListViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State var actualPage = 0
    @State private var searchText = ""

    var body: some View {
        TextField("Search", text: $searchText)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding()

        NavigationView {
            List {
                switch viewModel.charactersState {
                case .initial:
                    LoadingCell()
                case .loading:
                    ProgressView()
                case .error(let error):
                    ErrorCell()
                    Text(error)
                case .loaded(let data):
                    if searchText.isEmpty {
                        ForEach(data.results ?? [Results]()) { character in
                            NavigationLink {
                                DetailView(character: character)
                            } label: {
                                CharacterCell(results: character)
                            }
                        }
                    } else {
                        let filteredData = viewModel.filteredData(characters: data.results ?? [Results](),
                                                                  searchText: searchText)
                        ForEach(filteredData) { character in
                            NavigationLink {
                                DetailView(character: character)
                            } label: {
                                CharacterCell(results: character)
                            }
                        }
                    }

                }
            }
            .navigationTitle("Characters page:  " + String(viewModel.actualPage))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if viewModel.actualPage != 1 {
                        Button(action: {
                            viewModel.getPrev()
                        }) {
                            HStack {
                                Image(systemName: "arrow.left")
                                Text("Prev")
                            }
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.getNext()
                    }) {
                        HStack {
                            Text("Next")
                            Image(systemName: "arrow.right")
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RickAndMortyList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
