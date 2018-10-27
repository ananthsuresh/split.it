//
//  Friend.swift
//  split.it
//
//  Created by Ananth Suresh on 10/27/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit

class Friend {
    
    //MARK: Properties
    
    var name: String
    var venmoUsername: String

    init?(name: String, venmoUsername: String) {
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || venmoUsername.isEmpty {
            return nil
        }
        self.name = name
        self.venmoUsername = venmoUsername
        
    }
    
}
