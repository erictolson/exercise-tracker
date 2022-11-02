//
//  ExerciseDetailView.swift
//  ExerciseTracker
//
//  Created by Eric Tolson on 11/2/22.
//

import SwiftUI

struct ExerciseDetailView: View {
    var exercise: Exercise
    @State private var name = ""
    @State private var notes = ""
    @State private var duration = 0.0
    @State private var intensity = 1.0
    @State private var date = Date()
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    Text(exercise.name)
                } header: {
                    Text("Type of exercise")
                        .font(.headline)
                    }
                
                Section {
                    Text(String(exercise.date.formatted(.dateTime.day().month().year())))
                }
                header: {
                    Text("Date")
                        .font(.headline)
                }
                
                Section {
                    Text(String(exercise.duration.formatted()))
                }
                header: {
                    Text("Duration")
                        .font(.headline)
                }
                
                Section {
                    Text(exercise.duration.formatted())
                } header: {
                Text("Intensity")
                    .font(.headline)
                }
                
                Section {
                    Text(exercise.notes)
                } header: {
                    Text("Notes")
                        .font(.headline)
                }
                
            }
            .navigationTitle("Exercise Details")
        }
    }
}

struct ExerciseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let exercise = Exercise(name: "Example", date: Date(), notes: "Example", duration: 1.0, intensity: 1.0)
        
        ExerciseDetailView(exercise: exercise)
    }
}
