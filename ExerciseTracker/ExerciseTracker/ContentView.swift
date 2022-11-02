//
//  ContentView.swift
//  ExerciseTracker
//
//  Created by Eric Tolson on 11/1/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var exerciseList = ExerciseList()
    @State private var showingAddExercise = false
    @State private var strainLow = false
    @State private var strainHigh = false
    
    var body: some View {
        NavigationView {
            VStack{
                Form {
                    List {
                        Section{
                            if calcAverageStrain() == 0 {
                                Text("Add some exercise!")
                                    .font(.title3.bold())
                                    .foregroundColor(.blue)
                            } else {
                                Text("Average Strain: \(calcAverageStrain().formatted())")
                                    .font(.title3.bold())
                                    .foregroundColor(strainIndicator())
                                
                                if strainIndicator() == .yellow {
                                    Text("Consider increasing exercise duration or intensity next time.")
                                        .font(.subheadline)
                                } else if strainIndicator() == .red {
                                    Text("Consider decreasing exercise duration or intensity next time.")
                                        .font(.subheadline)
                                }
                            }
                        }
                        
                        ForEach(exerciseList.items) {
                            item in
                            NavigationLink {
                                ExerciseDetailView(exercise: item)
                            } label: {
                                HStack {
                                    VStack (alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                    }
                                    Spacer()
                                    
                                    Text("\(item.date.formatted(.dateTime.day().month().year()))")
                                }
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                }
                .navigationTitle("ExerciseTracker")
                .toolbar{
                    Button {
                        showingAddExercise = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $showingAddExercise) {
                    AddExerciseView(exerciseList: exerciseList)
                }
            }
            .alert("Consider increasing your exericse duration or intensity.", isPresented: $strainLow) {
                        Button("OK") { }
                    }
            .alert("Consider decreasing your exericse duration or intensity.", isPresented: $strainHigh) {
                        Button("OK") { }
                    }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        exerciseList.items.remove(atOffsets: offsets)
    }
    
    func calcAverageStrain() -> Double {
        var numberOfExercises: Double = 0
        var strainTotal: Double = 0
        var averageStrain: Double = 0
        
        for item in exerciseList.items {
            numberOfExercises += 1
            strainTotal += item.strain
        }
        
        averageStrain = strainTotal / numberOfExercises
        
        if exerciseList.items.isEmpty == true {
            return 0
        } else {
            return averageStrain
        }
    }
    
    func strainIndicator() -> Color {
        if calcAverageStrain() < 5 {
            return .yellow
        } else if calcAverageStrain() > 7 {
            return .red
        } else {
            return .green
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
