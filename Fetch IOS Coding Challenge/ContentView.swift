//
//  ContentView.swift
//  Fetch IOS Coding Challenge
//
//  Created by Jamescy Exime on 6/13/24.
//

import SwiftUI

struct ContentView: View {
    let mealService = MealService()
   
    var body: some View {
        VStack {
            MealListView(mealService: mealService)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
