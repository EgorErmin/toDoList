//
//  TaskTableViewCell.swift
//  toDoList
//
//  Created by Егор Ермин on 25.04.2020.
//  Copyright © 2020 Егор Ермин. All rights reserved.
//

import Foundation
import UIKit

// Table cell for displaying the name and date of issue creation
class TaskTableViewCell : UITableViewCell {

    @IBOutlet weak var nameTask: UILabel!
    @IBOutlet weak var dateTask: UILabel!
    
    func configureCell(name: String, date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        nameTask.text = name
        dateTask.text = dateFormatter.string(from: date)
    }
}
