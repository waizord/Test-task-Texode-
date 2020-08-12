//
//  Model.swift
//  Test task "Texode"
//
//  Created by Ivan on 8/12/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import UIKit

var pathForSaveData: String{
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true) [0] + "/data.plist"
    print(path)
    return path
}

var rootItem: TodoItem?

func loadData() {
    if let dict = NSDictionary.init(contentsOfFile: pathForSaveData){
        rootItem = TodoItem(dictionary: dict)
    } else {
        rootItem = TodoItem(name: "File is not find")
    }
}
    
func saveData(){
    rootItem?.dictionary.write(toFile: pathForSaveData, atomically: true)
}
