//
//  MealRowView.swift
//  Fetch IOS Coding Challenge
//
//  Created by Jamescy Exime on 6/13/24.
//

import SwiftUI

// View for displaying a single meal in the list
struct MealRowView: View {
    
    let meal: Meal
    var body: some View {
        HStack{
            // Display meal thumbnail
            AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            // Display meal name
            Text(meal.strMeal)
                .font(.headline)
        }
    }
}

#Preview {
    MealRowView(meal: SampleData.sampleMeal)
}
