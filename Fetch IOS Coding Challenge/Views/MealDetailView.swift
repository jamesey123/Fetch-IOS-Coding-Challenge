//
//  MealDetailView.swift
//  Fetch IOS Coding Challenge
//
//  Created by Jamescy Exime on 6/13/24.
//

import SwiftUI

// View for displaying detailed information about a meal
struct MealDetailView: View {
    
    @StateObject private var viewModel: MealDetailViewModel
    let mealId: String
    
    
    init(mealId: String, mealService: MealService) {
        self.mealId = mealId
        _viewModel = StateObject(wrappedValue: MealDetailViewModel(mealService: mealService))
    }
    
    var body: some View {
        
        VStack {
            if viewModel.mealDetail.idMeal.isEmpty {
                ProgressView()
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        // Display meal image
                        AsyncImage(url: URL(string: viewModel.mealDetail.strMealThumb)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Color.gray
                        }
                        .frame(height: 200)
                        .clipShape(Circle())
                        
                        // Display meal name
                        Text(viewModel.mealDetail.strMeal)
                            .font(.largeTitle)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.vertical)
                        


                        // Display meal instructions
                        Text("Instructions")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text(viewModel.mealDetail.strInstructions)
                            .padding(.bottom)
                        

                        // Display ingredients and measurements
                        Text("Ingredients")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        VStack(alignment: .leading) {
                            ForEach(viewModel.mealDetail.ingredients, id: \.name) { ingredient in
                                HStack {
                                    Text(ingredient.name)
                                        .fontWeight(.bold)
                                    Spacer()
                                    Text(ingredient.measure)
                                }
                                .padding(.vertical, 2)
                            }
                        }
                        .padding(.bottom)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.fetchMealDetail(id: mealId)
        }
        .navigationTitle("Meal Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MealDetailView(mealId: "52768", mealService: SampleData.sampleMealService)
}
