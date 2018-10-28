//
//  ItemViewController.swift
//  split.it
//
//  Created by Ananth Suresh on 10/28/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items = [Item]()
    @IBOutlet weak var itemTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTableView.delegate = self
        itemTableView.dataSource = self
        loadSampleItems()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ItemTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ItemTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ItemTableViewCell.")
        }
        
        
        // Fetches the appropriate meal for the data source layout.
        let item = items[indexPath.row]
        
        cell.nameLabel.text = item.name
        cell.priceLabel.text = String(item.price)
        
        return cell
    }
    
    //MARK: Private Methods
    
    private func loadSampleItems() {
        guard let item1 = Item(name: "Natty Daddy", price: 9.50) else {
            fatalError("Unable to instantiate item")
        }
        
        guard let item2 = Item(name: "Cereal", price: 4.50) else {
            fatalError("Unable to instantiate item")
        }
        items += [item1, item2]
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
