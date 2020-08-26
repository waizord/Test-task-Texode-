//
//  NSDictionary.swift
//  ToDo list
//
//  Created by Ivan on 8/20/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

class Direct {

    var todoItems: TodoItem?
    
//    init(todoItems: TodoItem) {
//        self.todoItems = todoItems
//    }
    
    
    var pathForSaveData: String {
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true) [0] + "/data.plist"
        print(path)
        return path
    }
    
    var dictionary: NSDictionary {

        var arraySubToDos = NSArray()
        if let todoItems = todoItems {
        for subitem in  todoItems.subItems {
                arraySubToDos = arraySubToDos.adding(subitem) as NSArray
            }
        
        
            let dictionary = NSDictionary(objects: [todoItems.name, todoItems.detail, arraySubToDos], forKeys: ["name" as NSCopying, "detail" as NSCopying, "subToDos" as NSCopying])
        
        return dictionary
        }
        return NSDictionary()
    }
    
    func loadData() {
        if let dict = NSDictionary.init(contentsOfFile: pathForSaveData){
            todoItems = TodoItem(dictionary: dict)
        } else {
            todoItems = TodoItem(name: "List")
        }
    }
        
    func saveData(){
        dictionary.write(toFile: pathForSaveData, atomically: true)
    }
}
