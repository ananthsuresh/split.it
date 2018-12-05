//
//  AssignItemsViewControllerCellTableViewCell.swift
//  split.it
//
//  Created by Ananth Suresh on 10/28/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit

// Specifies labels in each cell.  Both functions are required by swift and set to their default values.
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
