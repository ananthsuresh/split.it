//
//  FriendTests.swift
//  split.itTests
//
//  Created by Ananth Suresh on 10/29/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import XCTest
@testable import split_it

// Tests for Friend objects.
class FriendTests: XCTestCase {
    
    var Fabio:Friend!
    var Kieran:Friend!
    var Cheese = Item(name: "Cheese", price: 6.50)

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Fabio = Friend(name: "Fabio", venmoUsername: "fabiocapovilla")
        Kieran = Friend(name: "Kieran", venmoUsername: "derangedpenguin")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        Fabio = nil
        Kieran = nil
        Cheese = nil
    }

    func testThatFriendsStartWithZeroAmountOwed() {
        XCTAssertTrue(Kieran.amountOwed == 0)
        XCTAssertTrue(Fabio.amountOwed == 0)
    }
    
    func testAddItemOnePersonSplit(){
        Kieran.addItem(item: Cheese!)
        XCTAssertTrue(Kieran.amountOwed == 6.50)
    }
    
    func testAddItemTwoPersonSplit(){
        Kieran.addItem(item: Cheese!)
        Fabio.addItem(item: Cheese!)
        XCTAssertTrue(Kieran.amountOwed == 3.25)
        XCTAssertTrue(Fabio.amountOwed == 3.25)
    }
    
    func testRemoveItemAdjustsAmountOwed(){
        Kieran.addItem(item: Cheese!)
        Fabio.addItem(item: Cheese!)
        XCTAssertTrue(Kieran.amountOwed == 3.25)
        XCTAssertTrue(Fabio.amountOwed == 3.25)
        Kieran.removeItem(item: Cheese!)
        XCTAssertTrue(Kieran.amountOwed == 0)
        XCTAssertTrue(Fabio.amountOwed == 6.50)
    }
    
    func testRemoveItemNotInCart(){
        let Meat = Item(name: "Meat", price: 3.50)
        Kieran.addItem(item: Cheese!)
        Kieran.removeItem(item: Meat!)
        XCTAssertTrue(Kieran.items.count == 1)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
