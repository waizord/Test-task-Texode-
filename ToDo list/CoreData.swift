//
//  CoreData.swift
//  ToDo list
//
//  Created by Ivan on 10/23/20.
//  Copyright © 2020 Ivan. All rights reserved.
//
import CoreData

open class PersistantContainer: NSPersistentContainer  {
    public func saveContext(backgroungContext: NSManagedObjectContext?){
        let context = backgroungContext ?? viewContext
        guard context.hasChanges else {return}
        do{
            try context.save()
        }catch let error as NSError{
            print("Error: \(error), \(error.userInfo)")
        }
    }
}
