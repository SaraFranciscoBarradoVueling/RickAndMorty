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
    var body: some View {
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
                    ForEach(data.results ?? [Results]()) { character in
                        NavigationLink {
                            DetailView(character: character)
                        } label: {
                            CharacterCell(results: character)
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
                                Text("Next")
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
