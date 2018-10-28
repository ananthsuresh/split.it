//
//  AddFriendViewController.swift
//  split.it
//
//  Created by Ananth Suresh on 10/28/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var venmoUsername: UITextField!
    
    
    @IBAction func doneClick(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let receiverVC = segue.destination as! FriendTableViewController
        guard let friend = Friend(name: name.text!, venmoUsername: venmoUsername.text!) else {
            fatalError("Unable to instantiate friend")
        }
        print(receiverVC.friends)
        receiverVC.friends += [friend]
    }
 

}
