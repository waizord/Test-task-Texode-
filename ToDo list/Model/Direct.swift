//
//  NSDictionary.swift
//  ToDo list
//
//  Created by Ivan on 8/20/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

class Direct {

    var todoItems = TodoItem()

    var dictionary: NSDictionary {

        var arraySubToDos = NSArray()
        for subitem in  todoItems.subItems {
                arraySubToDos = arraySubToDos.adding(subitem) as NSArray
            }
        
        let dictionary = NSDictionary(objects: [todoItems.name, todoItems.detail, arraySubToDos], forKeys: ["name" as NSCopying, "detail" as NSCopying, "subToDos" as NSCopying])
        
        return dictionary
    }
    
    var pathForSaveData: String {
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true) [0] + "/data.plist"
        print(path)
        return path
    }
    

    
    func loadData() {
        if let dict = NSDictionary.init(contentsOfFile: pathForSaveData){
            todoItems = TodoItem(dictionary: dict)
            print("Load data")
        } else {
            todoItems = TodoItem(name: "List")
            print("No data")
        }
    }
        
    func saveData(){
        self.dictionary.write(toFile: pathForSaveData, atomically: true)
        print("Save data")
    }
}
