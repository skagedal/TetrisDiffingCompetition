//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit
import Differ

class DifferTetrisAdapter: TetrisAdapter {
    let name = "Differ"
    let comment = """
        I didn't get this one to work at all.  I think I'm calling it correctly, \
        but nothing shows. 
        """
    var collectionView: UICollectionView!

    var board = TetrisBoard(rows: [])
    func setBoard(_ tetrisBoard: TetrisBoard) {
        self.board = tetrisBoard
    }
    
    func animateBoard(to board: TetrisBoard, completion: ((Bool) -> Void)?) {
        collectionView.animateItemAndSectionChanges(oldData: self.board.rows,
                                                    newData: board.rows,
                                                    completion: completion)
    }
    
    func numberOfSections() -> Int {
        return board.rows.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return board.rows[section].blocks.count
    }
    
    func tetrisBlock(for indexPath: IndexPath) -> TetrisBlock {
        return board.rows[indexPath.section].blocks[indexPath.row]
    }
}

extension TetrisRow: Collection {
    typealias Element = TetrisBlock
    typealias Index = Array<TetrisBlock>.Index
    
    public var startIndex: Index { return blocks.startIndex }
    
    var endIndex: Index { return blocks.endIndex }
    
    subscript(position: Index) -> TetrisBlock {
        return blocks[position]
    }

    func index(after i: Index) -> Index {
        return blocks.index(after: i)
    }
}
