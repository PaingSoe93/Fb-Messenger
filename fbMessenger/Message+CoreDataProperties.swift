//
//  Message+CoreDataProperties.swift
//  fbMessenger
//
//  Created by Paing Aung on 6/13/18.
//  Copyright © 2018 Paing Aung. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var isSender: Bool
    @NSManaged public var friend: Friend?

}
