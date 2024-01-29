//
//  ChatMessage+CoreDataProperties.swift
//  ChatBot
//
//  Created by 최승범 on 2024/01/29.
//
//

import Foundation
import CoreData


extension ChatMessage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatMessage> {
        return NSFetchRequest<ChatMessage>(entityName: "ChatMessage")
    }

    @NSManaged public var content: String?
    @NSManaged public var id: UUID?
    @NSManaged public var role: String?
    @NSManaged public var date: Date?
    @NSManaged public var chatRoom: ChatRoom?

}

extension ChatMessage : Identifiable {

}
