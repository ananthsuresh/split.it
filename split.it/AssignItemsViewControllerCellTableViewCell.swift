//
//  AssignItemsViewControllerCellTableViewCell.swift
//  split.it
//
//  Created by Ananth Suresh on 10/28/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit

class AssignItemsViewControllerCellTableViewCell: UITableViewCell, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var assignedFriendLabel: UILabel!
    @IBOutlet weak var assignedFriendOwed: UILabel!
    @IBOutlet weak var isAssignedSwitch: UISwitch!
    weak var cellDelegate: AssignItemsTableViewCellDelegate?
    
    @IBAction func switchTriggered(_ sender: UISwitch) {
        cellDelegate?.didTriggerSwitch(sender.tag, isOn: sender.isOn)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
