//
//  WorkoutModel.swift
//  FitCheck
//
//  Created by Alex Bhandari on 5/13/24.
//

import Foundation

// MARK: - Welcome
struct WorkoutModel: Codable {
    let message: String
    let workoutTitle: String
    let workoutSchedule: [WorkoutSchedule]

    enum CodingKeys: String, CodingKey {
        case message
        case workoutTitle = "workout_title"
        case workoutSchedule = "workout_schedule"
    }
}

// MARK: - WorkoutSchedule
struct WorkoutSchedule: Codable {
    let day, workoutDescription: String
    let workout: [Workout]

    enum CodingKeys: String, CodingKey {
        case day
        case workoutDescription = "workout_description"
        case workout
    }
}

// MARK: - Workout
struct Workout: Codable {
    let exerciseName, exerciseDescription: String
    let exerciseSets, exerciseReps: String

    enum CodingKeys: String, CodingKey {
        case exerciseName = "exercise_name"
        case exerciseDescription = "exercise_description"
        case exerciseSets = "exercise_sets"
        case exerciseReps = "exercise_reps"
    }
}

