//
//  Meal.swift
//  FoodTracker
//
//  Created by Apprentice on 4/25/17.
//
//

import UIKit

class Meal {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage
    var rating: Int
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage!, rating: Int) { //this !! might be breaking everything
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0  {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        
    }
    
}
