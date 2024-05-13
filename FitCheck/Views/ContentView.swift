// ContentView.swift

import SwiftUI

struct ContentView: View {
    @State private var isPresented = false

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("My Workouts")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()

                    Spacer()

                    Button(action: {
                        isPresented.toggle()
                    }) {
                        Image(systemName: "bubble.right.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
                .padding([.leading, .trailing])

                MyWorkoutListView()
            }
            .sheet(isPresented: $isPresented) {
                ChatBotView()
            }
        }
    }
}


#Preview {
    ContentView()
}


