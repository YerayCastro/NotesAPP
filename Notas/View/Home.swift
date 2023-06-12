//
//  Home.swift
//  Notas
//
//  Created by Yery Castro on 18/2/23.
//

import SwiftUI

struct Home: View {
    
    @StateObject var model = ViewModel()
    
    @Environment(\.managedObjectContext) var context
    
    //@FetchRequest(entity: Notas.entity(), sortDescriptors: [NSSortDescriptor(key: "fecha", ascending: true)], animation: .spring()) var results: FetchedResults<Notas>
    
    @FetchRequest(entity: Notas.entity(), sortDescriptors: [], predicate: NSPredicate(format: "fecha <= %@", Date() as CVarArg), animation: .spring()) var results : FetchedResults<Notas>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(results) { item in
                    VStack(alignment: .leading) {
                        Text(item.nota ?? "Sin nota")
                            .font(.title)
                            .bold()
                        Text(item.fecha ?? Date(), style: .date)
                    }
                    .contextMenu(ContextMenu(menuItems: {
                        Button(action: {
                            model.sendData(item: item)
                        }) {
                            Label {
                                Text("Editar")
                            } icon: {
                                Image(systemName: "pencil")
                            }

                        }
                        Button(action: {
                            model.deleteDAta(item: item, context: context)
                        }) {
                            Label {
                                Text("Eliminar")
                            } icon: {
                                Image(systemName: "trash")
                            }
                        }
                    }))
                }
            }
            .navigationTitle("Notas")
            .toolbar {
                Button(action: {
                    model.show.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $model.show) {
                    AddView(model: model)
                }
            }
        }
        
    }
}

