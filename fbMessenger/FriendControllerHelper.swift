//
//  FriendControllerHelper.swift
//  fbMessenger
//
//  Created by Paing Aung on 4/24/18.
//  Copyright © 2018 Paing Aung. All rights reserved.
//

import UIKit
import CoreData

//class Friend: NSObject{
//    var name: String?
//    var profileImageName: String?
//}
//
//class Message: NSObject {
//    var text: String?
//    var date: Date?
//    
//    var friend: Friend?
//}

extension FriendsController {
    
    func clearData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            do{
                let entityNames = ["Friend", "Message"]
                for entityName in entityNames {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                    let objects = try(context.fetch(fetchRequest) as? [NSManagedObject])
                    for object in objects! {
                        context.delete(object)
                    }
                }
                try(context.save())
            } catch let err {
                print(err)
            }
        }
    }
    
    func setupData() {
        
        clearData()
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            createSteveMessageWithContext(context: context)
            
            let gandhi = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            gandhi.name = "Mahatma Gandhi"
            gandhi.profileImageName = "gandhi"
            
            FriendsController.createMessageWithText(text: "Made App, Not war", friend: gandhi, minAgo: 60 * 24, context: context)
            
            let hallary = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            hallary.name = "Hallary Clinton"
            hallary.profileImageName = "hillary_profile"
            
            FriendsController.createMessageWithText(text: "Vote me for Democarzy", friend: hallary, minAgo: 8 * 60 * 24, context: context)
            
            do{
                try(context.save())
            }catch let err {
                print(err)
            }
            
            //messages = [markMessage, steveMessage]
        }
        
        //loadData()
    }
    
    private func createSteveMessageWithContext(context: NSManagedObjectContext){
        let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        steve.name = "Steve Job"
        steve.profileImageName = "steve_profile"
        
        FriendsController.createMessageWithText(text: "Good Morning!", friend: steve, minAgo: 3, context: context)
        FriendsController.createMessageWithText(text: "Hello, How are you? I hope you are fine. As for me. I am fine and all the other in my family are fine too.", friend: steve, minAgo: 2, context: context)
        FriendsController.createMessageWithText(text: "Do you love to buy apple product! Are you thinking apple product is expensive? I need your feedback. Please be honest.", friend: steve, minAgo: 2, context: context)
        
        //response message
        FriendsController.createMessageWithText(text: "Yes, totally love it. But apple need some innovation. If i have money i will buy new iPhone.", friend: steve, minAgo: 2, context: context, isSender: true)
        
        FriendsController.createMessageWithText(text: "Ok. Apple will produce new iPhone in September. We will change the world. take your buy our phone", friend: steve, minAgo: 1, context: context)
        
        //response message
        FriendsController.createMessageWithText(text: "Of Course. I'll take my money and waiting to buy new iPhone. If it is innovated.", friend: steve, minAgo: 1, context: context, isSender: true)
    }
    
    static func createMessageWithText(text: String, friend: Friend, minAgo: Double, context: NSManagedObjectContext, isSender: Bool = false) {
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = Date().addingTimeInterval(-minAgo * 60) as NSDate
        message.isSender = isSender
        
        friend.lastMessage = message
    }
    
//    func loadData() {
//        let delegate = UIApplication.shared.delegate as? AppDelegate
//
//        if let context = delegate?.persistentContainer.viewContext {
//
//            if let friends = fetchFriend(){
//                messages = [Message]()
//                for friend in friends {
//                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
//                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
//                    fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
//                    fetchRequest.fetchLimit = 1
//                    do{
//
//                        let fetchMessages = try(context.fetch(fetchRequest) as? [Message])
//                        messages?.append(contentsOf: fetchMessages!)
//                    } catch let err {
//                        print(err)
//                    }
//                }
//                messages = messages?.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedDescending})
//            }
//        }
//    }
//
//    private func fetchFriend() -> [Friend]? {
//        let delegate = UIApplication.shared.delegate as? AppDelegate
//
//        if let context = delegate?.persistentContainer.viewContext {
//            do{
//                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
//                return try(context.fetch(request) as? [Friend])
//            }catch let err {
//                print(err)
//            }
//        }
//
//        return nil
//    }
}
