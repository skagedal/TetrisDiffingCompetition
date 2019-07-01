//
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class UICollectionViewDiffableDataSourceTetrisAdapter: TetrisAdapter {
    let name = "DiffableDataSource"
    let comment = """
        Added in iOS 13, this is the one we're all soon gonna use.  And it works great.
        """
    
    private var dataSource: UICollectionViewDiffableDataSource<TetrisRow, TetrisBlock>!
    
    func configure(collectionView: UICollectionView, cellProvider: @escaping (UICollectionView, IndexPath) -> UICollectionViewCell) {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, block in
            let cell = cellProvider(collectionView, indexPath)
            cell.configure(with: block)
            return cell
        }
    }
    
    func setBoard(_ board: TetrisBoard) {
        dataSource.apply(board.snapshot)
    }
    
    func animateBoard(to board: TetrisBoard, completion: ((Bool) -> Void)?) {
        dataSource.apply(board.snapshot, animatingDifferences: true)
        // Since we don't get a completion block
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            completion?(true)
        }
    }
}

@available(iOS 13.0, *)
private extension TetrisBoard {
    var snapshot: NSDiffableDataSourceSnapshot<TetrisRow, TetrisBlock> {
        let snapshot = NSDiffableDataSourceSnapshot<TetrisRow, TetrisBlock>()
        for row in rows {
            snapshot.appendSections([row])
            snapshot.appendItems(row.blocks, toSection: row)
        }
        return snapshot
    }
}
