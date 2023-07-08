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
    var body: some View {
        NavigationView {
            List {
                switch viewModel.charactersState {
                case .initial, .loading:
                    ProgressView()
                case .error(let error):
                    Text(error)
                case .loaded(let data):
                    ForEach(data.results ?? [Results]()) { character in
                        NavigationLink {
                            DetailView(character: character)
                        } label: {
                            CharacterCell(results: character)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationTitle("Characters page:  " + viewModel.returnActualPage())
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        viewModel.getNext()
                    }) {
                        HStack {
                            Text("Next page")
                            Image(systemName: "arrow.right")
                        }
                    }
                }
            }
        }
    }


    private func deleteItems(offsets: IndexSet) { // arreglar esta función
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RickAndMortyList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
