//
//  AssignItemsViewController.swift
//  split.it
//
//  Created by Ananth Suresh on 10/28/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit

class AssignItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AssignItemsTableViewCellDelegate {

    @IBOutlet weak var assignedItemsTableView: UITableView!
    @IBOutlet weak var itemNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameLabel.text = itemsList[0].name + " " + String(itemsList[0].price)
        assignedItemsTableView.delegate = self
        assignedItemsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
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
            cell.assignedFriendOwed.text = String(format:"%f", friends[i].amountOwed)
        }

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "AssignItemsViewControllerCellTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AssignItemsViewControllerCellTableViewCell  else {
            fatalError("The dequeued cell is not an instance of FriendTableViewCell.")
        }
        
        print(friends[indexPath.row])
        
        // Fetches the appropriate meal for the data source layout.
        let friend = friends[indexPath.row]
        cell.cellDelegate = self
        cell.isAssignedSwitch.tag = indexPath.row
        cell.assignedFriendLabel.text = friend.name
        cell.assignedFriendOwed.text = String(format:"%f", friend.amountOwed)
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func doneButtonClicked(_ sender: Any) {
        print(itemsList.count)
        itemsList.removeFirst(1)
        print(itemsList.count)
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
