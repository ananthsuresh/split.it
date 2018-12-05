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

// File corresponding to the "Friends" page
class FriendTableViewController: UIViewController, G8TesseractDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePickerController: UIImagePickerController!
    let tesseract:G8Tesseract = G8Tesseract(language:"eng");
    
    @IBOutlet weak var processingLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var friendTableView: UITableView!
    
    // Sets up settings for tesseract and table.
    override func viewDidLoad() {
        super.viewDidLoad()
        if firstLoad{
            friends.append(Friend(name: "Me", venmoUsername: "N/A")!)
            firstLoad = false
        }
        tesseract.engineMode = .tesseractCubeCombined
        tesseract.pageSegmentationMode = .auto
        tesseract.delegate = self
        friendTableView.delegate = self
        friendTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Function required by swift for tables, specifies number of sections for the table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Function required by swift for tables, gives the length of the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    // Function required by swift for tables, populates tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "FriendTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FriendTableViewCell  else {
            fatalError("The dequeued cell is not an instance of FriendTableViewCell.")
        }
        
        
        // Fetches the appropriate meal for the data source layout
        let friend = friends[indexPath.row]
        
        cell.nameLabel.text = friend.name
        cell.editButton.tag = indexPath.row + 1
        return cell
    }

    // Override to support editing the table view to allow for "edit" functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Does necessary checks depending on what button is clicked
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let button = sender as? UIButton{
            // Used for all "edit" button clicks to pre-fill the text fields in /
            // the "add friends" page
            if (button.tag > 0){
                let index = button.tag
                let friend = friends[index]
                let receiverVC = segue.destination as! AddFriendViewController
                receiverVC.nameString = friend.name
                receiverVC.venmoUsernameString = friend.venmoUsername
                receiverVC.editIndex = index
            }
            // Makes sure friends exist before going to create a itemization
            else if (button.tag < 0){
                checkValidFriends()
            }
        }
    }
    
    // Opens camera and runs Tesseract if the "take picture" button is clicked
    @IBAction func takePicture(_ sender: Any) {
        checkValidFriends()
        imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = false
        imagePickerController.delegate = self
        present(imagePickerController, animated:true, completion: nil)
    }
    
    // Makes sure that there is at least one other friend other than the "Me"
    private func checkValidFriends(){
        if(friends.count < 2){
            let alert = UIAlertController(title: "More friends required", message: "Please add at least one other friend", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return;
        }
    }
    
    // Swift internal function that brings up camera for user
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        imagePickerController.dismiss(animated: true, completion: {
            self.performSegue(withIdentifier: "pictureToItemListSegue", sender: nil)
        })
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        // Starts the "processing" animation
        activityIndicator.startAnimating()
        processingLabel.isHidden = false
        
        // Once user selects "use photo" run tesseract on that image and determine
        // the items from the text in the photo
        dismiss(animated: true, completion: {
            if let tesseract = G8Tesseract(language: "eng+fra"){
                tesseract.image = image!.g8_blackAndWhite()
                tesseract.recognize()
                let text = tesseract.recognizedText
                self.createItemsFromText(text: text!)
            }
        })

    }
    
    // Used to replace the preprocessor for Tesseract to GPUImage
    // Uses a filter that goes pixel by pixel and makes it either white or black
    func preprocessedImageForTesseract(tesseract: G8Tesseract, sourceImage: UIImage) -> UIImage{
        let filter = AdaptiveThreshold()
        filter.blurRadiusInPixels = 4.0
        let filteredImage = sourceImage.filterWithOperation(filter)
        return filteredImage
    }
    
    func createItemsFromText(text: String){
        let lines = text.components(separatedBy: "\n")
        for line in lines{
            let matched = findStrings(for: "\\d+[._]\\d{2}\\s[FT]", in: line)
            if(matched.count == 0){
                continue
            }
            if (findStrings(for: "[a-z]|[A-Z]", in: line).count == 0){
                continue;
            }
            var match = matched[0]
            match.removeLast(2)
            let price = Double(match)
            let itemName = line.components(separatedBy: match)[0]
            itemsList.append(Item(name: itemName, price: price!)!)
        }
    }
    
    // Based off of code from: https://stackoverflow.com/questions/27880650/swift-extract-regex-matches
    func findStrings(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch _ {
            print("invalid regex")
            return []
        }
    }

}
