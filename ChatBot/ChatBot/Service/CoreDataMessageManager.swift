//
//  CoreDataMessageManager.swift
//  ChatBot
//
//  Created by 최승범 on 2024/01/29.
//

import Foundation

struct CoreDataMessageManager {
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    func readMessages(from chatRoom: ChatRoom) throws -> [Message] {
        let request = ChatMessage.fetchRequest()
        request.predicate = NSPredicate(format: "chatRoom == %@", chatRoom)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        let chatMessages = try coreDataManager.context.fetch(request)
        return chatMessages.map { Message(role: Role(rawValue: $0.role!)!, content: $0.content!) }
    }
    
    func writeMessage(_ message: Message, for chatRoom: ChatRoom) {
        let context = coreDataManager.context
        let entitiy = ChatMessage.entity()
        let messageCD = ChatMessage(entity: entitiy, insertInto: context)
        messageCD.id = message.id
        messageCD.role = message.role.rawValue
        messageCD.content = message.content
        messageCD.date = message.created
        messageCD.chatRoom = chatRoom
    }
    
    func saveContext() {
        coreDataManager.saveContext()
    }
}
