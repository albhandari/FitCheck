//
//  WorkoutDetailView.swift
//  FitCheck
//
//  Created by Alex Bhandari on 5/13/24.
//

import SwiftUI

struct WorkoutDetailView: View {
    @EnvironmentObject var myWorkoutsVM: MyWorkoutsViewModel
    var workoutModel: WorkoutModel?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Display a welcoming message or introduction
                Text(workoutModel?.workoutTitle ?? "Welcome to your Workout Schedule")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.leading, .trailing, .top], 20)

                if let schedules = workoutModel?.workoutSchedule {
                    ForEach(schedules, id: \.day) { schedule in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(schedule.day)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.top, 10)  // Adding top padding to the day

                            Text(schedule.workoutDescription)
                                .font(.body)
                                .foregroundColor(.secondary)
                                .padding(.bottom, 10)

                            ForEach(schedule.workout, id: \.exerciseName) { exercise in
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(exercise.exerciseName)
                                        .font(.headline)
                                        .fontWeight(.medium)

                                    Text(exercise.exerciseDescription)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)

                                    HStack {
                                        Text("Sets: \(exercise.exerciseSets)")
                                        Text("Reps: \(exercise.exerciseReps)")
                                    }
                                }
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            }
                        }
                        .padding([.leading, .trailing], 20)
                        .padding(.bottom, 10)  // Adding bottom padding after exercises
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                    }
                } else {
                    Text("No workout details are available.")
                        .foregroundColor(.secondary)
                }
                
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            
        }
        Button("Add to my Workouts") {
            if let workout = workoutModel {
                myWorkoutsVM.addWorkout(workout)
            }
            // Define the action here
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.blue)
        .foregroundColor(Color.white)
        .cornerRadius(12)
        .padding([.leading, .trailing, .bottom], 20)
    }
}

#Preview {
    WorkoutDetailView(workoutModel: WorkoutModel(message: "Your Weekly Fitness Plan",workoutTitle: "Grind Week", workoutSchedule: [
                WorkoutSchedule(day: "Monday", workoutDescription: "Leg Day", workout: [
                    Workout(exerciseName: "Squat", exerciseDescription: "Perform back squats.", exerciseSets: "3", exerciseReps: "12"),
                    Workout(exerciseName: "Leg Press", exerciseDescription: "Use the leg press machine.", exerciseSets: "3", exerciseReps: "10")
                ]),
                WorkoutSchedule(day: "Wednesday", workoutDescription: "Upper Body Day", workout: [
                    Workout(exerciseName: "Bench Press", exerciseDescription: "Flat bench press.", exerciseSets: "3", exerciseReps: "10"),
                    Workout(exerciseName: "Pull Ups", exerciseDescription: "Do wide grip pull ups.", exerciseSets: "2", exerciseReps: "8")
                ])
            ]))
}
