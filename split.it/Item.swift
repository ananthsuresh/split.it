//
//  Item.swift
//  split.it
//
//  Created by Ananth Suresh on 10/28/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit

// Class used to hold each item's information
class Item: Equatable {
    
    //MARK: Properties
    
    var name: String
    var price: Double
    var friends: [Friend] = []
    
    init?(name: String, price: Double) {
        // Initialization should fail if there is no name or if the rating is negative.
        if /*name.isEmpty || */price.isNaN || price <= 0 {
            return nil
        }
        self.name = name
        self.price = price
        
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.price == rhs.price
    }
    
}
