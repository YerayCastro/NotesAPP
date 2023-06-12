//
//  ViewModel.swift
//  Notas
//
//  Created by Yery Castro on 18/2/23.
//

import Foundation
import CoreData
import SwiftUI

class ViewModel: ObservableObject {
    @Published var nota = ""
    @Published var fecha = Date()
    @Published var show = false
    @Published var updateItem: Notas!
    
    //CoreData
    // Función para guardar los datos
    func saveData(context: NSManagedObjectContext) {
        let newNota = Notas(context: context)
        newNota.nota = nota
        newNota.fecha = fecha
        
        do {
            try context.save()
            print("Guardó")
            show.toggle()
        } catch let error as NSError {
            //alerta al usuario
            print("No guardó", error.localizedDescription)
        }
    }
    
    // Función para eliminar los datos
    func deleteDAta(item: Notas, context: NSManagedObjectContext) {
        context.delete(item)
        do {
            try context.save()
            print("Eliminó")
            show.toggle()
        } catch let error as NSError {
            //alerta al usuario
            print("No Eliminó", error.localizedDescription)
        }
    }
    
    // Función para enviar los datos
    func sendData(item: Notas) {
        updateItem = item
        nota = item.nota ?? ""
        fecha = item.fecha ?? Date()
        show.toggle()
    }
    
    //Función para editar los datos
    func editData(context: NSManagedObjectContext) {
        updateItem.fecha = fecha
        updateItem.nota = nota
        do {
            try context.save()
            print("Editó")
            show.toggle()
        } catch let error as NSError {
            //alerta al usuario
            print("No Editó", error.localizedDescription)
        }
    }
}
