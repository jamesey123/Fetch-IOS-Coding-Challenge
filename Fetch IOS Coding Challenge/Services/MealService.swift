//
//  MealService.swift
//  Fetch IOS Coding Challenge
//
//  Created by Jamescy Exime on 6/13/24.
//

import Foundation
import Combine

// Service class for fetching meal data from the API
class MealService {
    
    private let baseURL = "https://themealdb.com/api/json/v1/1"
    private let urlSession: URLSession
    
    // Initialize URLSession with caching configuration
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = URLCache(memoryCapacity: 20 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: nil)
        self.urlSession = URLSession(configuration: configuration)
    }
    
    
    // Fetch the list of dessert meals
    func fetchDesserts() -> AnyPublisher<[Meal], Error> {
        guard let url = URL(string: "\(baseURL)/filter.php?c=Dessert") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [String: [Meal]].self, decoder: JSONDecoder())
            .map { $0["meals"] ?? [] }
            .eraseToAnyPublisher()
    }
    
    // Fetch detailed information about a meal by its ID
    func fetchMealDetail(id: String) -> AnyPublisher<MealDetail, Error> {
        guard let url = URL(string: "\(baseURL)/lookup.php?i=\(id)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .handleEvents(receiveOutput: { data in
                // Print raw JSON response for debugging
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON Response: \(jsonString)")
                }
            })
            .decode(type: [String: [MealDetail]].self, decoder: JSONDecoder())
            .map { $0["meals"]?.first ?? MealDetail() }
            .eraseToAnyPublisher()
    }
    
    
}
