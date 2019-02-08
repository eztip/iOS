//
//  WorkerTableViewCell.swift
//  Tippr
//
//  Created by Cameron Dunn on 2/8/19.
//  Copyright © 2019 Cameron Dunn. All rights reserved.
//

import UIKit

class WorkerTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    var worker = Worker()
}
