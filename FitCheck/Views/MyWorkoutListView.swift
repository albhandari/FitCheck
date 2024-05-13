//
//  MyWorkoutListView.swift
//  FitCheck
//
//  Created by Alex Bhandari on 5/13/24.
//

import SwiftUI

struct MyWorkoutListView: View {
    
    @EnvironmentObject var myWorkoutsVM: MyWorkoutsViewModel
    
    var body: some View {
        
        NavigationSplitView {
            List(myWorkoutsVM.myWorkouts, id: \.workoutTitle) { myWorkout in
                NavigationLink {
                    MyWorkoutDetailView(workoutModel: myWorkout)
                } label: {
                    WorkoutRowView(workout: myWorkout)
                }
            }
            
            
        } detail: {
            Text("Select a Workout")
        }
        
    }
}



struct WorkoutRowView: View {
    var workout: WorkoutModel

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(workout.workoutTitle)
                .font(.headline)
                .fontWeight(.bold)
            
            Text(workout.message)
                .font(.subheadline)
                .lineLimit(2)
                .truncationMode(.tail)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

struct MyWorkoutDetailView: View {
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
    }
}

#Preview {
    MyWorkoutListView()
}
