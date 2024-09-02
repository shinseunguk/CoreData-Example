//
//  ContentView.swift
//  CoreData-Example
//
//  Created by ukseung.dev on 8/30/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Person.updateDate!, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Person>
    
    @State var name: String = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Placeholder", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            VStack {
                                Text("id => \(item.id ?? "nil")")
                                Text("name => \(item.name ?? "nil")")
                                Text("updateDate => \(item.updateDate ?? Date(), formatter: itemFormatter)")
                            }
                        } label: {
                            Text("데이터 저장 일시 \(item.updateDate!, formatter: itemFormatter)")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }
    
    private func generateID() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let dateString = dateFormatter.string(from: Date())
        return dateString
    }
    
    ///  Core Data CRUD중 Create
    private func addItem() {
        withAnimation {
            let newItem = Person(context: viewContext)
            newItem.id = generateID()
            newItem.updateDate = Date()
            newItem.name = name
            
            do {
                try viewContext.save()
                name = ""
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    ///  Core Data CRUD중 Delete
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

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
