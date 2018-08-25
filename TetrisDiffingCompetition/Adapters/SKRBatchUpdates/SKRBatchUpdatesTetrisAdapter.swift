//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

class SKRBatchUpdatesTetrisAdapter: TetrisAdapter {
    let name = "SKRBatchUpdates"
    let comment = """
        My diffing engine. The original Collection View Tetris diffing engine.
        """
    var collectionView: UICollectionView!

    private let dataSource = DataSource<TetrisRow, TetrisBlock>()

    func setBoard(_ tetrisBoard: TetrisBoard) {
        dataSource.sections = tetrisBoard.dataSource
    }

    func animateBoard(to board: TetrisBoard, completion: ((Bool) -> Void)?)  {
        dataSource.animate(to: board.dataSource, in: collectionView, completion: completion)
    }

    func numberOfSections() -> Int {
        return dataSource.numberOfSections()
    }
    
    func numberOfRows(in section: Int) -> Int {
        return dataSource.numberOfRows(in: section)
    }
    
    func tetrisBlock(for indexPath: IndexPath) -> TetrisBlock {
        return dataSource.itemForRow(at: indexPath)
    }
}

private extension TetrisBoard {
    var dataSource: [(TetrisRow, [TetrisBlock])] {
        return rows.map { ($0, $0.blocks) }
    }
}
