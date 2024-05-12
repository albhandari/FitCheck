import SwiftUI
import Foundation

struct HomePageView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Header
                Text("Fitness App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                // Welcome Message
                Text("Welcome back, User!")
                    .font(.title2)
                    .padding(.bottom, 20)
                
                // Quick Access Buttons
                VStack(spacing: 20) {
                    NavigationLink(destination: StartWorkoutView()) {
                        Text("Start Workout")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: ProgressView()) {
                        Text("View Progress")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: SettingsView()) {
                        Text("Settings")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                }
                .padding()

                Spacer()

                // Bottom Navigation Bar
                HStack {
                    Image(systemName: "house.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(20)
                    Spacer()
                    Image(systemName: "chart.bar.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(20)
                    Spacer()
                    Image(systemName: "gear")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(20)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

struct StartWorkoutView: View {
    var body: some View {
        Text("Start Workout View")
    }
}

struct ProgressView: View {
    var body: some View {
        Text("Progress View")
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings View")
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
