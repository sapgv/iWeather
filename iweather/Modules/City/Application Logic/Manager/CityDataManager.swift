//
//  CityDataManager.swift
//  iweather
//
//  Created by Гриша on 19.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import CoreData

class CityDataManager {
    
    var coreDataStore : CoreDataStore?
    
    func findLocations(completion: (([Location]) -> Void)!) {
        
        coreDataStore?.fetchLocations(completionBlock: { entries in
            let locations = self.locationsFromCoreStoreEntries(entries)
            completion(locations)
            
        })
    }
    
    func locationsFromCoreStoreEntries(_ entries: [_Location]) -> [Location] {
        
        let locations: [Location] = entries.map { entry in
            Location(name: entry.name!, lat: entry.lat, lon: entry.lon)
        }
        return locations
        
    }
    
    func deleteLocation(_ location: Location) {
        coreDataStore?.deleteLocation(location)
    }
//    func todoItemsBetweenStartDate(_ startDate: Date, endDate: Date, completion: (([TodoItem]) -> Void)!) {
//        let calendar = Calendar.autoupdatingCurrent
//        let beginning = calendar.dateForBeginningOfDay(startDate)
//        let end = calendar.dateForEndOfDay(endDate)
//        
//        let predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", beginning as CVarArg, end as CVarArg)
//        let sortDescriptors: [NSSortDescriptor] = []
//        
//        coreDataStore?.fetchEntriesWithPredicate(predicate,
//                                                 sortDescriptors: sortDescriptors,
//                                                 completionBlock: { entries in
//                                                    let todoItems = self.todoItemsFromDataStoreEntries(entries)
//                                                    completion(todoItems)
//        })
//    }
//    
//    func todoItemsFromDataStoreEntries(_ entries: [ManagedTodoItem]) -> [TodoItem] {
//        let todoItems : [TodoItem] = entries.map { entry in
//            TodoItem(dueDate: entry.date, name: entry.name as String)
//        }
//        
//        return todoItems
//    }
    
}
