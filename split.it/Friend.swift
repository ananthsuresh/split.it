//
//  Friend.swift
//  split.it
//
//  Created by Ananth Suresh on 10/27/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit

class Friend: Equatable{
    
    //MARK: Properties
    
    var name: String
    var venmoUsername: String
    var amountOwed: Double = 0
    var items: [Item] = []

    init?(name: String, venmoUsername: String) {
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || venmoUsername.isEmpty {
            return nil
        }
        self.name = name
        self.venmoUsername = venmoUsername
        
    }
    
    func addItem(item: Item){
        self.items.append(item)
        let oldPrice = (item.price / Double(item.friends.count))
        item.friends.append(self)
        let newPrice = (item.price / Double(item.friends.count))
        self.amountOwed += newPrice
        for friend in item.friends {
            if friend != self{
                friend.amountOwed = friend.amountOwed - oldPrice + newPrice
            }
        }
    }
    
    func removeItem(item: Item){
        let itemIndex = self.items.index(of: item)
        let friendIndex = item.friends.index(of: self)
        if itemIndex != nil && friendIndex != nil{
            self.items.remove(at: itemIndex!)
            let pricePaid = item.price / Double(item.friends.count)
            self.amountOwed -= pricePaid
            item.friends.remove(at: friendIndex!)
            for friend in item.friends {
                if friend != self {
                    let newPrice = item.price / Double(item.friends.count)
                    friend.amountOwed = friend.amountOwed - pricePaid + newPrice
                }
            }
        }
    }
    
    static func == (lhs: Friend, rhs: Friend) -> Bool {
        return lhs.name == rhs.name && lhs.venmoUsername == rhs.venmoUsername
    }
    
    
}
