//
//  MealListView.swift
//  Fetch IOS Coding Challenge
//
//  Created by Jamescy Exime on 6/13/24.
//

import SwiftUI


// View for displaying the list of dessert meals
struct MealListView: View {
    @StateObject private var viewModel: MealsViewModel
    
    init(mealService: MealService) {
        _viewModel = StateObject(wrappedValue: MealsViewModel(mealService: mealService))
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: MealDetailView(mealId: meal.idMeal, mealService: viewModel.mealService)) {
                    MealRowView(meal: meal)
                }
            }
            .navigationTitle("Desserts")
            .onAppear {
                viewModel.fetchDesserts()
            }
        }
    }
}

#Preview {
    MealListView(mealService: SampleData.sampleMealService)
}

