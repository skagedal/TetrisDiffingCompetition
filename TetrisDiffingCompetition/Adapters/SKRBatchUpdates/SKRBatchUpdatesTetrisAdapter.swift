//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

class SKRBatchUpdatesTetrisAdapter: NSObject, TetrisAdapter, UICollectionViewDataSource {
    let name = "SKRBatchUpdates"
    let comment = """
        My diffing engine. The original Collection View Tetris diffing engine.
        """

    func configure(collectionView: UICollectionView, cellProvider: @escaping (UICollectionView, IndexPath) -> UICollectionViewCell) {
        self.collectionView = collectionView
        collectionView.dataSource = self
        self.cellProvider = cellProvider
    }

    private var collectionView: UICollectionView!
    private var cellProvider: ((UICollectionView, IndexPath) -> UICollectionViewCell)!

    private let dataSource = DataSource<TetrisRow, TetrisBlock>()

    func setBoard(_ tetrisBoard: TetrisBoard) {
        dataSource.sections = tetrisBoard.dataSource
    }

    func animateBoard(to board: TetrisBoard, completion: ((Bool) -> Void)?)  {
        dataSource.animate(to: board.dataSource, in: collectionView, completion: completion)
    }

    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfRows(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cellProvider(collectionView, indexPath)
        let block = dataSource.itemForRow(at: indexPath)
        cell.configure(with: block)
        return cell
    }
}

private extension TetrisBoard {
    var dataSource: [(TetrisRow, [TetrisBlock])] {
        return rows.map { ($0, $0.blocks) }
    }
}
