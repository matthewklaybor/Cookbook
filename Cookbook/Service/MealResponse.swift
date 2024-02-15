//
//  MealResponse.swift
//  CookbookApp
//
//  Created by Matthew Klaybor on 2/12/24.
//

import Foundation

struct MealResponse: Decodable {
    let meals: [Meal]
}


// Example JSON Response
//{
//  "meals": [
//    {
//      "strMeal": "Apam balik",
//      "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
//      "idMeal": "53049"
//    },
//    {
//      "strMeal": "Apple & Blackberry Crumble",
//      "strMealThumb": "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
//      "idMeal": "52893"
//    },
//    {
//      "strMeal": "Apple Frangipan Tart",
//      "strMealThumb": "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg",
//      "idMeal": "52768"
//    }
//  ]
//}
