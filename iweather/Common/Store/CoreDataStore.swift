//
//  CoreDataStore.swift
//  iweather
//
//  Created by Гриша on 19.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStore: NSObject {
    
    var persistentStoreCoordinator : NSPersistentStoreCoordinator!
    var managedObjectModel : NSManagedObjectModel!
    var managedObjectContext : NSManagedObjectContext!
    
    override init() {
        
        managedObjectModel = NSManagedObjectModel.mergedModel(from: nil)
        
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        let domains = FileManager.SearchPathDomainMask.userDomainMask
        let directory = FileManager.SearchPathDirectory.documentDirectory
        
        let applicationDocumentsDirectory = FileManager.default.urls(for: directory, in: domains).first!
        let options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
        
        let storeURL = applicationDocumentsDirectory.appendingPathComponent("iWeather.sqlite")
        
        try! persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        managedObjectContext.undoManager = nil
        
        super.init()
    }
    
    func fetchLocations(completionBlock: (([_Location]) -> Void)!) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>  = NSFetchRequest(entityName: "Location")
        
        managedObjectContext.perform {
            let queryResults = try? self.managedObjectContext.fetch(fetchRequest)
            let managedResults = queryResults! as! [_Location]
            completionBlock(managedResults)
        }
    }
    
    func fetchLocation(_ name: String) -> _Location? {
        let fetchRequest = NSFetchRequest<_Location>(entityName: "Location")
        let description = NSEntityDescription.entity(forEntityName: "Location", in: managedObjectContext)!
        fetchRequest.entity = description
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        let results = try? managedObjectContext.fetch(fetchRequest)
        let object = results?.first
        return object
    }
    
    func newLocation() -> _Location {
        let newLocation = NSEntityDescription.insertNewObject(forEntityName: "Location", into: managedObjectContext) as! _Location
        return newLocation
    }
    
    func deleteLocation(_ location: Location) {
        
        if let loctionDeleting = fetchLocation(location.name) {
            managedObjectContext.delete(loctionDeleting)
            save()
        }
        
    }
    
    func save() {
        do {
            try managedObjectContext.save()
        } catch let error {
            print(error)
        }
    }
    
    
}
