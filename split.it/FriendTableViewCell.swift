//
//  FriendTableViewCell.swift
//  split.it
//
//  Created by Ananth Suresh on 10/27/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell, UIImagePickerControllerDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBAction func editFriend(_ sender: UIButton) {
    }
    @IBOutlet weak var editButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
