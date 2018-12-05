//
//  AssignItemsTableViewCellDelegate.swift
//  split.it
//
//  Created by Ananth Suresh on 11/19/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import Foundation

// Required by swift for table, corresponds to AssignItemsViewController's table
protocol AssignItemsTableViewCellDelegate : class {
    func didTriggerSwitch(_ tag: Int, isOn: Bool)
}
