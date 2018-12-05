//
//  FriendTableViewController.swift
//  split.it
//
//  Created by Ananth Suresh on 10/27/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit
import TesseractOCR
import GPUImage

var friends = [Friend]()
var itemsList = [Item]()
private var firstLoad = true

class FriendTableViewController: UIViewController, G8TesseractDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var processingLabel: UILabel!
    var imagePickerController: UIImagePickerController!
    let tesseract:G8Tesseract = G8Tesseract(language:"eng");
    
    //MARK: Properties

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var friendTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if firstLoad{
            friends.append(Friend(name: "Me", venmoUsername: "NA")!)
            firstLoad = false
        }
        tesseract.engineMode = .tesseractCubeCombined
        tesseract.pageSegmentationMode = .auto
        tesseract.delegate = self
        friendTableView.delegate = self
        friendTableView.dataSource = self
        // Load the sample data.
//        loadSampleFriends()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return friends.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "FriendTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FriendTableViewCell  else {
            fatalError("The dequeued cell is not an instance of FriendTableViewCell.")
        }
        
        
        // Fetches the appropriate meal for the data source layout.
        let friend = friends[indexPath.row]
        
        cell.nameLabel.text = friend.name
        cell.editButton.tag = indexPath.row + 1
        return cell
    }

 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        /*
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        */
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let button = sender as? UIButton{
            if (button.tag > 0){
                let index = button.tag
                let friend = friends[index]
                let receiverVC = segue.destination as! AddFriendViewController
                receiverVC.nameString = friend.name
                receiverVC.venmoUsernameString = friend.venmoUsername
                receiverVC.editIndex = index
            } else if (button.tag < 0){
                if(friends.count < 2){
                    let alert = UIAlertController(title: "More friends required", message: "Please add at least one other friend", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    return;
                }
            }
        }
    }
 
    
    //MARK: Private Methods
    
    private func loadSampleFriends() {
        guard let friend1 = Friend(name: "Kieran", venmoUsername: "kieranaulak") else {
            fatalError("Unable to instantiate friend1")
        }
        
        guard let friend2 = Friend(name: "Fabio", venmoUsername: "fabiocapovilla") else {
            fatalError("Unable to instantiate friend2")
        }
        friends += [friend1, friend2]
    }
    
    @IBAction func takePicture(_ sender: Any) {
        if(friends.count < 2){
            let alert = UIAlertController(title: "More friends required", message: "Please add at least one other friend", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return;
        }
        imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = false
        imagePickerController.delegate = self
        present(imagePickerController, animated:true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        imagePickerController.dismiss(animated: true, completion: {
            self.performSegue(withIdentifier: "pictureToItemListSegue", sender: nil)
        })
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        activityIndicator.startAnimating()
        processingLabel.isHidden = false
        dismiss(animated: true, completion: {
            if let tesseract = G8Tesseract(language: "eng+fra"){
                tesseract.image = image!.g8_blackAndWhite()
                tesseract.recognize()
                let text = tesseract.recognizedText
                self.createItemsFromText(text: text!)
                //dismiss(animated: false, completion: nil)
            }
        })

    }
    
    func preprocessedImageForTesseract(tesseract: G8Tesseract, sourceImage: UIImage) -> UIImage{
        let filter = AdaptiveThreshold()
        filter.blurRadiusInPixels = 4.0
        //            filter.threshold = 4.0
        
        // Retrieve the filtered image from the filter
        let filteredImage = sourceImage.filterWithOperation(filter)
        
        // Give Tesseract the filtered image
        
        return filteredImage
    }
    
    func createItemsFromText(text: String){
        let lines = text.components(separatedBy: "\n")
        for line in lines{
            let matched = matches(for: "\\d+[._]\\d{2}\\s[FT]", in: line)
            if(matched.count == 0){
                continue
            }
            if (matches(for: "[a-z]|[A-Z]", in: line).count == 0){
                continue;
            }
            var match = matched[0]
            match.removeLast(2)
            let price = Double(match)
            let itemName = line.components(separatedBy: match)[0]
            itemsList.append(Item(name: itemName, price: price!)!)
        }
    }
    
    func matches(for regex: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }

}
