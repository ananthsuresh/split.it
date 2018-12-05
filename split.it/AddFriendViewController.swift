//
//  AddFriendViewController.swift
//  split.it
//
//  Created by Ananth Suresh on 10/28/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit

// File corresponding to the "Add Friend" page
class AddFriendViewController: UIViewController {
    
    var editIndex : Int? = -1
    var nameString : String? = ""
    var venmoUsernameString : String? = ""
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var venmoUsername: UITextField!
        
    @IBAction func doneClick(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = nameString
        venmoUsername.text = venmoUsernameString
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Makes sure all fields are filled before moving back to "Friend" page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(name.text! == ""){
            let alert = UIAlertController(title: "No name", message: "Please input a name", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return;
        }
        if(venmoUsername.text! == ""){
            let alert = UIAlertController(title: "No venmo username", message: "Please input a valid username", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return;
        }
        guard let friend = Friend(name: name.text!, venmoUsername: venmoUsername.text!) else {
            fatalError("Unable to instantiate friend")
        }
        if(editIndex == -1){
            friends += [friend]
        }
        else{
            friends[editIndex!] = friend
        }
    }
 

}
