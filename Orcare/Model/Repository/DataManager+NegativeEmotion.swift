//
//  DataManager+NegativeEmotion.swift
//  Orcare
//
//  Created by Yossan Sandi Rahmadi on 05/05/21.
//

import Foundation
import CoreData

extension DataManager {
    func addNegativeEmotion(name: String, image: String, desc: String) -> NegativeEmotion {
        let negativeEmotion = NegativeEmotion(context: persistentContainer.viewContext)
        
        negativeEmotion.name = name
        negativeEmotion.image = image
        negativeEmotion.desc = desc
        negativeEmotion.isActive = false
        
        saveContext()
        
        return negativeEmotion
    }
    
    
    func getNegativeEmotion(at index: Int) -> NegativeEmotion {
        let request: NSFetchRequest<NegativeEmotion> = NegativeEmotion.fetchRequest()
        
        var fetchedNegativeEmotions: [NegativeEmotion] = []
        
        do {
            fetchedNegativeEmotions = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching negative emotions")
        }
        
        return fetchedNegativeEmotions[index]
    }
    
    func getNegativeEmotions() -> [NegativeEmotion] {
        let request: NSFetchRequest<NegativeEmotion> = NegativeEmotion.fetchRequest()
        
        var fetchedNegativeEmotions: [NegativeEmotion] = []
        
        do {
            fetchedNegativeEmotions = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching negative emotions")
        }
        
        return fetchedNegativeEmotions
    }
    
    func getActiveNegativeEmotions() -> [NegativeEmotion] {
        let request: NSFetchRequest<NegativeEmotion> = NegativeEmotion.fetchRequest()
        
        request.predicate = NSPredicate(format: "isActive == true")
        
        var fetchedNegativeEmotions: [NegativeEmotion] = []
        
        do {
            fetchedNegativeEmotions = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching negative emotions")
        }
        
        return fetchedNegativeEmotions
    }
    
    func activateNegativeEmotion(negativeEmotion: NegativeEmotion) {
        negativeEmotion.isActive = true
        
        saveContext()
    }
    
    func deactivateNegativeEmotion(negativeEmotion: NegativeEmotion) {
        negativeEmotion.isActive = false
        
        saveContext()
    }
    
    func deteleAllNegativeEmotions() {
        let negativeEmotions = getNegativeEmotions()
        
        for negativeEmotion in negativeEmotions {
            persistentContainer.viewContext.delete(negativeEmotion)
        }
        
        saveContext()
    }
}
