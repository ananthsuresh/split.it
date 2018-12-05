//
//  FinalTotalsViewController.swift
//  split.it
//
//  Created by Ananth Suresh on 12/4/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit

class FinalTotalsViewController: UIViewController {

    @IBOutlet weak var totalsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabels()
    }
    
    // Sets the label equal to all the friend's totals
    func setLabels(){
        var labelText = ""
        for i in 0..<friends.count {
            labelText += String(friends[i].name) + "\t\t\t\t" + String(friends[i].amountOwed)
        }
        totalsLabel.text = labelText
    }
}
