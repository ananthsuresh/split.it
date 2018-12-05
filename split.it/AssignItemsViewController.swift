//
//  AssignItemsViewController.swift
//  split.it
//
//  Created by Ananth Suresh on 10/28/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit

// File corresponding to the "Assign Items" page
class AssignItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AssignItemsTableViewCellDelegate {

    @IBOutlet weak var assignedItemsTableView: UITableView!
    @IBOutlet weak var itemNameLabel: UILabel!
    
    // Sets up the labels with the current price and item name
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameLabel.text = itemsList[0].name + " $" + String(format:"%.02f", itemsList[0].price)
        assignedItemsTableView.delegate = self
        assignedItemsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    // Sets correct running totals for each friend when a new switch is toggled
    func didTriggerSwitch(_ tag: Int, isOn: Bool) {
        let friend = friends[tag]
        let item = itemsList[0]
        if(isOn){
            friend.addItem(item: item)
        }
        else{
            friend.removeItem(item: item)
        }
        for i in 0..<friends.count {
            let indexPath = IndexPath(item: i, section: 0)
            guard let cell = self.assignedItemsTableView.cellForRow(at: indexPath) as? AssignItemsViewControllerCellTableViewCell else {
                fatalError("The dequeued cell is not an instance of FriendTableViewCell.")
            }
            cell.assignedFriendOwed.text = "$" + String(format:"%.02f", friends[i].amountOwed)
        }

        
    }
    
    // Function required by swift for tables, specifies the number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Function required by swift for tables, specifies length of table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    // Sets up table with correct information
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "AssignItemsViewControllerCellTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AssignItemsViewControllerCellTableViewCell  else {
            fatalError("The dequeued cell is not an instance of FriendTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let friend = friends[indexPath.row]
        cell.cellDelegate = self
        cell.isAssignedSwitch.tag = indexPath.row
        cell.assignedFriendLabel.text = friend.name
        cell.assignedFriendOwed.text = "$" + String(format:"%.02f", friend.amountOwed)
        return cell
    }
    
    // Goes to the next item, if no next item goes to the Venmo page.
    @IBAction func doneButtonClicked(_ sender: Any) {
        itemsList.removeFirst(1)
        if(itemsList.count > 0){
            for i in 0..<friends.count {
                let indexPath = IndexPath(item: i, section: 0)
                guard let cell = self.assignedItemsTableView.cellForRow(at: indexPath) as? AssignItemsViewControllerCellTableViewCell else {
                    fatalError("The dequeued cell is not an instance of FriendTableViewCell.")
                }
                cell.isAssignedSwitch.isOn = false
            }
            self.viewDidLoad()
        } else {
            performSegue(withIdentifier: "segueToRequestPage", sender: nil)
        }
    }
}
