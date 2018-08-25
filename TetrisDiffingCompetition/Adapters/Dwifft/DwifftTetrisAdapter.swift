//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit
import Dwifft

class DwifftTetrisAdapter: TetrisAdapter {
    let name = "Dwifft"
    let comment = """
        Works, but doesn't seem to be doing moves, so the block pieces jump between sections.
        """
    var collectionView: UICollectionView! {
        didSet {
            diffCalculator = CollectionViewDiffCalculator(collectionView: collectionView)
        }
    }
    
    private var diffCalculator: CollectionViewDiffCalculator<TetrisRow, TetrisBlock>!
    
    func setBoard(_ tetrisBoard: TetrisBoard) {
        // Setting diffCalculator?.sectionedValues = SectionedValues(tetrisBoard.dataSource) here crashes.
    }
    
    func animateBoard(to board: TetrisBoard, completion: ((Bool) -> Void)?) {
        diffCalculator.sectionedValues = SectionedValues(board.dataSource)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            completion?(true)
        }
    }
    
    func numberOfSections() -> Int {
        return diffCalculator.numberOfSections()
    }
    
    func numberOfRows(in section: Int) -> Int {
        return diffCalculator.numberOfObjects(inSection: section)
    }
    
    func tetrisBlock(for indexPath: IndexPath) -> TetrisBlock {
        return diffCalculator.value(atIndexPath: indexPath)
    }
}

private extension TetrisBoard {
    var dataSource: [(TetrisRow, [TetrisBlock])] {
        return rows.map { ($0, $0.blocks) }
    }
}
