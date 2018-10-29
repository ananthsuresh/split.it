//
//  AssignItemsViewController.swift
//  split.it
//
//  Created by Ananth Suresh on 10/28/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit

class AssignItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var assignedItemsTableView: UITableView!
    @IBOutlet weak var itemNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameLabel.text = itemsList[0].name + " " + String(itemsList[0].price)
        assignedItemsTableView.delegate = self
        assignedItemsTableView.dataSource = self
        // Do any additional setup after loading the view.
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
        
        cell.assignedFriendLabel.text = friend.name
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
            self.viewDidLoad()
        } else {
            print("done")
        }
    }
}
