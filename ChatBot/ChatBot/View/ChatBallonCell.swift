//
//  ChatBallonCell.swift
//  ChatBot
//
//  Created by 김수경 on 2024/01/12.
//

import UIKit

final class ChatBallonCell: UICollectionViewListCell {
    
    private lazy var chatBallonView: ChatBallon = {
        let view = ChatBallon()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("ChatBallonCell Init Error")
    }
    
    private func configure() {
        self.contentView.addSubview(chatBallonView)
        
        NSLayoutConstraint.activate([
            chatBallonView.topAnchor.constraint(equalTo: contentView.topAnchor),
            chatBallonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            chatBallonView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.8),
            chatBallonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func setLabelText(text: String) {
        chatBallonView.label.text = text
    }
}
