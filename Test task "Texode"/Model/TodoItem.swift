//
//  TodoItem.swift
//  Test task "Texode"
//
//  Created by Ivan on 8/12/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import UIKit

class TodoItem {
    var name: String?
    var isComplete: Bool
    
    var subItems: [TodoItem]
    
    init(name: String) {
        self.name = name
        self.isComplete = false
        
        self.subItems = []
    }
    
    func addSubItem(subItem: TodoItem){
        subItems.append(subItem)
    }
}
