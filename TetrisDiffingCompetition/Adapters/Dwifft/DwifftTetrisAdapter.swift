//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit
import Dwifft

class DwifftTetrisAdapter: NSObject, TetrisAdapter, UICollectionViewDataSource {
    let name = "Dwifft"
    let comment = """
        Works, but doesn't seem to be doing moves, so the block pieces jump between sections.
        """

    func configure(collectionView: UICollectionView, cellProvider: @escaping (UICollectionView, IndexPath) -> UICollectionViewCell) {
        self.collectionView = collectionView
        collectionView.dataSource = self
        self.cellProvider = cellProvider
        diffCalculator = CollectionViewDiffCalculator(collectionView: collectionView)
    }
    
    private var collectionView: UICollectionView!
    private var cellProvider: ((UICollectionView, IndexPath) -> UICollectionViewCell)!
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

    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return diffCalculator.numberOfSections()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diffCalculator.numberOfObjects(inSection: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cellProvider(collectionView, indexPath)
        let block = diffCalculator.value(atIndexPath: indexPath)
        cell.configure(with: block)
        return cell
    }
}

private extension TetrisBoard {
    var dataSource: [(TetrisRow, [TetrisBlock])] {
        return rows.map { ($0, $0.blocks) }
    }
}
