//
//  ChatListViewController.swift
//  ChatBot
//
//  Created by 최승범 on 2024/01/30.
//

import UIKit

class ChatListViewController: UIViewController {

    var collectionView: ChatListCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView = ChatListCollectionView()
        collectionView.delegate = self
        
        configure()
    }
    
    private func configure() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "plus.message.fill"), style: .plain, target: self, action: #selector(addChatRoom))]
        
        view.addSubview(collectionView)
        collectionView.configure(view: view)
        
    }
    
    @objc private func addChatRoom() {
        
    }

}



extension ChatListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(ChattingViewController(), animated: true)
    }
}
