//
//  ExerciseList.swift
//  ExerciseTracker
//
//  Created by Eric Tolson on 11/1/22.
//

import Foundation

class ExerciseList: ObservableObject {
    @Published var items = [Exercise]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([Exercise].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}
