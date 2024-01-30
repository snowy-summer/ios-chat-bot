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

    func readChatRooms() throws -> [ChatRoom] {
        let context = coreDataManager.context
        let request = ChatRoom.fetchRequest()
        return try context.fetch(request)
    }
    
    func writeChatRoom(model: ChatRoomModel) {
        let context = coreDataManager.context
        let entity = ChatRoom.entity()
        let chatRoom = ChatRoom(entity: entity, insertInto: context)
        
        chatRoom.title = model.title
        chatRoom.date = model.date
        chatRoom.id = model.id
    }
    
    func saveContext() {
        coreDataManager.saveContext()
    }
}
