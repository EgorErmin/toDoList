//
//  RealmModels.swift
//  toDoList
//
//  Created by Егор Ермин on 25.04.2020.
//  Copyright © 2020 Егор Ермин. All rights reserved.
//

import Foundation
import RealmSwift

// Task model
class Task : Object {
    // Name task
    @objc dynamic var name = ""
    // Description task
    @objc dynamic var notes = ""
    // Вate the issue was created
    @objc dynamic var createdAt = Date()
    // State task
    @objc dynamic var isCompleted = false
}
