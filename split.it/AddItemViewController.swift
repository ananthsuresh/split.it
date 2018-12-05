//
//  AddItemViewController.swift
//  split.it
//
//  Created by Ananth Suresh on 10/28/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit

// File used for "Add Item" page
class AddItemViewController: UIViewController {

    @IBOutlet weak var itemNameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    var itemNameString : String? = ""
    var priceString : String? = ""
    var existingItemIndex : Int? = -1
    

    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameField.text = itemNameString
        priceField.text = priceString
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Make sures all fields are filled in before going back to "Item's" page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let price = Double(priceField.text!) else {
            let alert = UIAlertController(title: "Invalid price", message: "Please input a valid price", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return;
        }
        if(itemNameField.text! == ""){
            let alert = UIAlertController(title: "No item name specified", message: "Please specify item name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return;
        }
        guard let item = Item(name: itemNameField.text!, price: price) else {
            fatalError("Item could not be created")
        }
        if(existingItemIndex != -1){
            itemsList[existingItemIndex!] = item
        }
        else{
            itemsList += [item]
        }

    }
 

}
