//
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class UICollectionViewDiffableDataSourceTetrisAdapter: TetrisAdapter {
    let name = "class UICollectionViewDiffableDataSource"
    let comment = """
        Added in iOS 13.
        """
    
    private var dataSource: UICollectionViewDiffableDataSource<TetrisRow, TetrisBlock>!
    
    func configure(collectionView: UICollectionView, cellProvider: @escaping (UICollectionView, IndexPath) -> UICollectionViewCell) {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = cellProvider(collectionView, indexPath)
            let block = self.tetrisBlock(for: indexPath)
            cell.configure(with: block)
            return cell
        }
    }
    
    func setBoard(_ tetrisBoard: TetrisBoard) {
        
    }
    
    func animateBoard(to board: TetrisBoard, completion: ((Bool) -> Void)?) {
        
    }
    
    func numberOfSections() -> Int {
        return 0
        
    }
    
    func numberOfRows(in section: Int) -> Int {
        return 0
    }
    
    func tetrisBlock(for indexPath: IndexPath) -> TetrisBlock {
        return TetrisBlock(identifier: 0, type: .empty)
    }
}
