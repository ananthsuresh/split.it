//
//  SendRequestViewController.swift
//  split.it
//
//  Created by Ananth Suresh on 11/20/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit

// Allows for different behavior the first time this page is loaded
private var firstLoad = true

// File corresponding to the "Send Request" page
class SendRequestViewController: UIViewController {
    @IBOutlet weak var friendLabel: UILabel!
    @IBOutlet weak var amountOwedLabel: UILabel!
    
    // Sets up labels for screen.
    override func viewDidLoad() {
        super.viewDidLoad()
        if firstLoad {
            friends.removeFirst(1)
            firstLoad = false
        }
        friendLabel.text = friends[0].name;
        amountOwedLabel.text = String(format:"%.02f", friends[0].amountOwed);
    }
    
    // Opens Venmo with the specified parameters in the request
    @IBAction func sendRequest(_ sender: Any) {
        let amountOwed:String = String(format:"%.02f", friends[0].amountOwed);
        let venmoUsername:String = friends[0].venmoUsername;
        guard let url = URL(string: "venmo://paycharge?txn=pay&recipients=\(venmoUsername)&amount=\(amountOwed)&note=Note") else { return }
        UIApplication.shared.open(url)
        friends.removeFirst(1)
        if(friends.count > 0){
            self.viewDidLoad()
        }
        else {
            performSegue(withIdentifier: "backToStart", sender: nil)
        }
    }
}
