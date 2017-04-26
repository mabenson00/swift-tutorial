//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Apprentice on 4/25/17.
//
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    //MARK: Meal Class Tests
    
    //Confirm that the meal initializer returns a meal object when passed valid parametersa
    func testMealInitializationSucceds() {
        
        //zero rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        //highest rating
        let positiveRatingMeal = Meal.init(name:"Positive", photo: nil, rating: 0)
        XCTAssertNotNil(positiveRatingMeal)
    }
    
    func testMealInitializationFails() {
        //negative rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        //emmpty string
        
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
    }
    
}
