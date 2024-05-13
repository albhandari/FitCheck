//
//  MyWorkoutsViewModel.swift
//  FitCheck
//
//  Created by Alex Bhandari on 5/13/24.
//

import Foundation

class MyWorkoutsViewModel: ObservableObject {
    @Published var myWorkouts: [WorkoutModel] = []

    func addWorkout(_ workout: WorkoutModel) {
        myWorkouts.append(workout)
    }
}
