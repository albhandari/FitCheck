//
//  FitCheckApp.swift
//  FitCheck
//
//  Created by Alex Bhandari on 3/29/24.
//

import SwiftUI

@main
struct FitCheckApp: App {
    var myWorkoutsViewModel = MyWorkoutsViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(myWorkoutsViewModel)
        }
    }
}
