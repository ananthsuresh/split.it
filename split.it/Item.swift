//
//  Item.swift
//  split.it
//
//  Created by Ananth Suresh on 10/28/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit

class Item {
    
    //MARK: Properties
    
    var name: String
    var price: Double
    
    init?(name: String, price: Double) {
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || price.isNaN {
            return nil
        }
        self.name = name
        self.price = price
        
    }
    
}
