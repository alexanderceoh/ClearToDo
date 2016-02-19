//
//  ToDoItem.swift
//  ClearToDo
//
//  Created by alex oh on 2/15/16.
//  Copyright © 2016 Alex Oh. All rights reserved.
//

import UIKit

class ToDoItem: NSObject {

    var text: String
    var completed: Bool
    
    init(text: String) {
        self.text = text
        self.completed = false
    }
    
}
