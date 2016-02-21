//
//  ViewController.swift
//  CoreDataBasics
//
//  Created by Dustin M on 2/20/16.
//  Copyright © 2016 Vento. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
        
        
        newUser.setValue("Dustin", forKey: "username")
        newUser.setValue("touchdown", forKey: "password")
        
        do {
            
            try context.save()
            
        } catch{
            
            print("an error ocurred")
            
        }
        
        

        let request = NSFetchRequest(entityName: "Users")
        
        request.predicate = NSPredicate(format: "username = %@", "Dustin")
        request.predicate = NSPredicate(format: "password =%@", "touchdown")
        
        request.returnsObjectsAsFaults = false //needed to make data accessible
        
        do {
            
            let results = try context.executeFetchRequest(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    //context.deleteObject(result) //used to delete an entry
                    
                    if let username = result.valueForKey("username") as? String {
                        print(username)

                    }
                    
                    /*
                    print(result.valueForKey("username")!)
                    print(result.valueForKey("password")!)
                    */
                }
                
            }
            
        } catch {
            
            print("uh oh")
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

