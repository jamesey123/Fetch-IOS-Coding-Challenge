//
//  MealDetailViewModel.swift
//  Fetch IOS Coding Challenge
//
//  Created by Jamescy Exime on 6/13/24.
//

import Foundation
import Combine

// ViewModel for handling detailed information about a specific meal
class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail = MealDetail()
    private var cancellables: Set<AnyCancellable> = []
    private let mealService: MealService
    
    // Initialize with a MealService instance
    init(mealService: MealService) {
        self.mealService = mealService
    }
    
    // Fetch meal detail by its ID
    func fetchMealDetail(id: String) {
        mealService.fetchMealDetail(id: id)
            .receive(on: DispatchQueue.main)
            .replaceError(with: MealDetail())
            .sink(receiveValue: { [weak self] detail in
                self?.mealDetail = detail
                //print(detail)
            })
            .store(in: &cancellables)
        
    }
}



