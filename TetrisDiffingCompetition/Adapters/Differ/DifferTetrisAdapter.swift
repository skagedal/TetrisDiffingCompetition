//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit
import Differ

class DifferTetrisAdapter: NSObject, TetrisAdapter, UICollectionViewDataSource {
    let name = "Differ"
    let comment = """
        I didn't get this one to work at all.  I think I'm calling it correctly, \
        but nothing shows. 
        """
    
    func configure(collectionView: UICollectionView, cellProvider: @escaping (UICollectionView, IndexPath) -> UICollectionViewCell) {
        self.collectionView = collectionView
        collectionView.dataSource = self
        self.cellProvider = cellProvider
    }
    
    private var collectionView: UICollectionView!
    private var cellProvider: ((UICollectionView, IndexPath) -> UICollectionViewCell)!

    var board = TetrisBoard(rows: [])
    func setBoard(_ tetrisBoard: TetrisBoard) {
        self.board = tetrisBoard
    }
    
    func animateBoard(to board: TetrisBoard, completion: ((Bool) -> Void)?) {
        collectionView.animateItemAndSectionChanges(oldData: self.board.rows,
                                                    newData: board.rows,
                                                    completion: completion)
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return board.rows.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return board.rows[section].blocks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cellProvider(collectionView, indexPath)
        let block = board.rows[indexPath.section].blocks[indexPath.row]
        cell.configure(with: block)
        return cell
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
