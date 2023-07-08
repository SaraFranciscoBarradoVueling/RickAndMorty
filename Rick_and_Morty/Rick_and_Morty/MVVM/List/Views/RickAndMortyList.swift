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
                VStack {
                    switch viewModel.charactersState {
                    case .initial, .loading:
                        ProgressView()
                    case .error(let error):
                        Text(error)
                    case .loaded(let data):
                        ScrollView {
                            ForEach(data.results ?? [Results]()) { character in
                                NavigationLink {
                                    DetailView(image: character.image ?? "",
                                               name: "",
                                               info: "",
                                               moreInfo: "")
                                    Text("Item at " + (character.name ?? ""))
                                } label: {
                                    CharacterCell(results: character)
                                }
                            }
                            .onDelete(perform: deleteItems)
                        }
                                    .toolbar {
                                        ToolbarItem {
                                            Button(action: addItem) {
                                                Label("Add Item", systemImage: "arrow.right")
                                            }
                                        }
                                    }
                    }
                }
                .navigationTitle("Characters")
                //                ForEach(items) { item in
                //                    NavigationLink {
                //                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                //                    } label: {
                //                        Text(item.timestamp!, formatter: itemFormatter)
                //                    }
                //                }
                //                .onDelete(perform: deleteItems)
                //            }
                //            .toolbar {
                //                ToolbarItem(placement: .navigationBarTrailing) {
                //                    EditButton()
                //                }
                //                ToolbarItem {
                //                    Button(action: addItem) {
                //                        Label("Add Item", systemImage: "plus")
                //                    }
                //                }
                //            }
                //            Text("Select an item")
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

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

    private func deleteItems(offsets: IndexSet) {
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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RickAndMortyList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
