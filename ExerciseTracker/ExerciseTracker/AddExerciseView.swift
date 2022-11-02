//
//  AddExerciseView.swift
//  ExerciseTracker
//
//  Created by Eric Tolson on 11/1/22.
//

import SwiftUI

struct AddExerciseView: View {
    @ObservedObject var exerciseList: ExerciseList
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var notes = ""
    @State private var duration = 0.0
    @State private var intensity = 1.0
    @State private var date = Date()
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("", text: $name)
                } header: {
                    Text("Type of exercise")
                        .font(.headline)
                    }
                
                Section {
                    DatePicker(selection: $date, in: ...Date(), displayedComponents: .date)
                        {
                        Text("Select a date")
                    }
                }
                header: {
                    Text("Date")
                        .font(.headline)
                }
                
                Section {
                    Stepper("\(duration.formatted()) hours", value: $duration, in: 0...4, step: 0.25)
                } header: {
                Text("Duration")
                    .font(.headline)
                }
                
                Section {
                    Stepper("\(intensity.formatted())/10", value: $intensity, in: 1...10)
                } header: {
                Text("Intensity")
                    .font(.headline)
                }
                
                Section {
                    TextEditor(text: $notes)
                } header: {
                    Text("Notes")
                        .font(.headline)
                }
            }
            .navigationTitle("Add Exercise")
            .toolbar{
                Button("Add") {
                    let item = Exercise(name: name, date: date, notes: notes, duration: duration, intensity: intensity)
                    exerciseList.items.append(item)
                    dismiss()
                }
                .disabled(hasValidinfo == false)

            }
        }
    }
    
    var hasValidinfo: Bool {
        if name.isEmpty || duration == 0 {
            return false
        }
        
        return true
    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseView(exerciseList: ExerciseList())
    }
}
