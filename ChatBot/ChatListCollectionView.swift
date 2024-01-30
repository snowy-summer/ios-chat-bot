//
//  ChatListCollectionView.swift
//  ChatBot
//
//  Created by 최승범 on 2024/01/30.
//

import UIKit

final class ChatListCollectionView: UICollectionView {
    private var diffableDataSource: DiffableDataSource?
    
    init() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(view: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - typealias

extension ChatListCollectionView {
    private typealias CellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ChatRoomModel>
    private typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, ChatRoomModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ChatRoomModel>
}


// MARK: - DiffableDataSource

extension ChatListCollectionView {
    private func configureDataSource() {
        let cellRegistration = CellRegistration { (cell, indexPath, itemIdentifier) in
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY.MM.DD HH시 mm분"
            
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = itemIdentifier.title
            contentConfiguration.secondaryText = dateFormatter.string(from: itemIdentifier.date)
            cell.contentConfiguration = contentConfiguration
         
        }
        
        diffableDataSource = DiffableDataSource(collectionView: self, cellProvider: { collectionView, indexPath, itemIdentifier in
           
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        saveSnapshot(record: [ChatRoomModel(title: "aaa", date: Date())])
    }

    func saveSnapshot(record: [ChatRoomModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(record, toSection: .main)
        diffableDataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    
}
