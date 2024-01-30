//
//  ChatRoomModel.swift
//  ChatBot
//
//  Created by 최승범 on 2024/01/30.
//

import Foundation

struct ChatRoomModel: Identifiable {
    let id = UUID()
    let title: String
    let date: Date
}

extension ChatRoomModel: Hashable {
    static func == (lhs: ChatRoomModel, rhs: ChatRoomModel) -> Bool {
        lhs.id == rhs.id
    }
}
