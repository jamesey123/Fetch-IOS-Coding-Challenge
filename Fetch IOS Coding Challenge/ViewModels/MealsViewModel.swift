//
//  MealsViewModel.swift
//  Fetch IOS Coding Challenge
//
//  Created by Jamescy Exime on 6/13/24.
//

import Foundation
import Combine

// ViewModel for handling the list of dessert meals
class MealsViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    private var cancellables: Set<AnyCancellable> = []
    let mealService: MealService
    
    // Initialize with a MealService instance
    init(mealService: MealService) {
        self.mealService = mealService
    }
    
    // Fetch dessert meals and sort them alphabetically
    func fetchDesserts() {
        mealService.fetchDesserts()
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .map {$0.sorted {$0.strMeal < $1.strMeal} }
            .sink(receiveValue: { [weak self] meals in
                self?.meals = meals
                print(meals[0])
            })
            .store(in: &cancellables)
    }
}
