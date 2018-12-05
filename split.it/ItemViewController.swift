//
//  ItemViewController.swift
//  split.it
//
//  Created by Ananth Suresh on 10/28/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var itemTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTableView.delegate = self
        itemTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Function required from swift for tables, specifies number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Function required from swift for tables, specifies length of table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    // Populates table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ItemTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ItemTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ItemTableViewCell.")
        }
        
        
        // Fetches the appropriate meal for the data source layout.
        let item = itemsList[indexPath.row]
        
        cell.nameLabel.text = item.name
        cell.priceLabel.text = "$" + String(format:"%.02f", item.price)
        
        return cell
    }
    
    // Used for when single row is selected from table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "editItemSegue", sender: indexPath.row)
    }
    
    // Allows for editing each row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            itemsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Populates fields if "edit" button is selected
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editItemSegue"){
            let receiverVC = segue.destination as! AddItemViewController
            let index = sender as! Int
            let item = itemsList[index]
            receiverVC.itemNameString = item.name
            receiverVC.priceString = String(item.price)
            receiverVC.existingItemIndex = index
        
        }
     }
    

}
