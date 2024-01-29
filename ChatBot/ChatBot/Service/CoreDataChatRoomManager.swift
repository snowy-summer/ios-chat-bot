//
//  CoreDataChatRoomManager.swift
//  ChatBot
//
//  Created by 김수경 on 2024/01/29.
//

import Foundation

struct CoreDataChatRoomManager {
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    func saveContext() {
        coreDataManager.saveContext()
    }
    
    func readChatRooms() throws -> [ChatRoom] {
        let context = coreDataManager.context
        let request = ChatRoom.fetchRequest()
        return try context.fetch(request)
    }
    
    func writeChatRoom(title: String, date: Date) {
        let context = coreDataManager.context
        let entity = ChatRoom.entity()
        var chatRoom = ChatRoom(entity: entity, insertInto: context)
        
        chatRoom.title = title
        chatRoom.date = date
        chatRoom.id = UUID()
    }
}
