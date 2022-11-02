//
//  Exercise.swift
//  ExerciseTracker
//
//  Created by Eric Tolson on 11/1/22.
//

import Foundation

struct Exercise: Identifiable, Codable {
    var id = UUID()
    var name: String
    var date: Date
    var notes: String
    var duration: Double
    var intensity: Double
    
    var strain: Double {
        duration * intensity
    }
}
