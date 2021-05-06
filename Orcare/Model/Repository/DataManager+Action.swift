//
//  DataManager+Action.swift
//  Orcare
//
//  Created by Yossan Sandi Rahmadi on 05/05/21.
//

import Foundation
import CoreData

extension DataManager {
    func addAction(title: String, negativeEmotion: NegativeEmotion) -> Action {
        let action = Action(context: persistentContainer.viewContext)
        
        action.title = title
        action.isDone = false
        action.totalSolved = 0
        action.negativeEmotion = negativeEmotion
        
        saveContext()
        return action
    }
    
    func getActions(negativeEmotion: NegativeEmotion) -> [Action] {
        let request: NSFetchRequest<Action> = Action.fetchRequest()
        
        request.predicate = NSPredicate(format: "negativeEmotion = %@", negativeEmotion)
        
        
        var fetchedActions: [Action] = []
        
        do {
          fetchedActions = try persistentContainer.viewContext.fetch(request)
        } catch {
          print("Error fetching actions")
        }
        
        return fetchedActions
    }
    
    func editAction(action: Action, title: String? = nil, isDone: Bool? = nil, totalSolved: Int? = nil) {
        if let safeTitle = title {
            action.title = safeTitle
        }
        
        if let safeIsDone = isDone {
            action.isDone = safeIsDone
        }
        
        if let safeTotalSolved = totalSolved {
            action.totalSolved = Int32(Int(action.totalSolved) - safeTotalSolved)
        }
        
        saveContext()
    }
    
    func deleteAction(action: Action) {
        persistentContainer.viewContext.delete(action)
        
        saveContext()
    }
    
    func countDoneAction(from actions: NSSet) -> Int {
        var total = 0
        for case let action as Action in actions {
            if action.isDone {
                total += 1
            }
        }
        
        return total
    }
}
