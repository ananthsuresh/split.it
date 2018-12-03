//
//  SendRequestViewController.swift
//  split.it
//
//  Created by Ananth Suresh on 11/20/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit

private var firstLoad = true

class SendRequestViewController: UIViewController {
    @IBOutlet weak var friendLabel: UILabel!
    @IBOutlet weak var amountOwedLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if firstLoad {
            friends.removeFirst(1)
            firstLoad = false
        }
        // Do any additional setup after loading the view.
        friendLabel.text = friends[0].name;
        amountOwedLabel.text = String(format:"%.02f", friends[0].amountOwed);
    }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
