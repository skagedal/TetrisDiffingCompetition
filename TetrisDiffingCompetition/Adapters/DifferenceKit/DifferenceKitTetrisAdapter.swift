//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit
import DifferenceKit

class DifferenceKitTetrisAdapter: NSObject, TetrisAdapter, UICollectionViewDataSource {
    let name = "DifferenceKit"
    let comment = """
        Works super-nice!
        """

    func configure(collectionView: UICollectionView, cellProvider: @escaping (UICollectionView, IndexPath) -> UICollectionViewCell) {
        self.collectionView = collectionView
        collectionView.dataSource = self
        self.cellProvider = cellProvider
    }
    
    private var collectionView: UICollectionView!
    private var cellProvider: ((UICollectionView, IndexPath) -> UICollectionViewCell)!

    private var sections: [ArraySection<TetrisRow, TetrisBlock>] = []
    
    func setBoard(_ tetrisBoard: TetrisBoard) {
        sections = tetrisBoard.sections
    }
    
    func animateBoard(to board: TetrisBoard, completion: ((Bool) -> Void)?) {
        let changes = StagedChangeset(source: sections, target: board.sections)
        collectionView.reload(using: changes, setData: { newSections in
            self.sections = newSections
        })
        // Since DifferenceKit does not let us provide completion block
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            completion?(true)
        }
    }

    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cellProvider(collectionView, indexPath)
        let block = sections[indexPath.section].elements[indexPath.row]
        cell.configure(with: block)
        return cell
    }
}

private extension TetrisBoard {
    var sections: [ArraySection<TetrisRow, TetrisBlock>] {
        return rows.map {
            ArraySection<TetrisRow, TetrisBlock>(model: $0, elements: $0.blocks)
        }
    }
}

extension TetrisRow: Differentiable {
    typealias DifferenceIdentifier = Int
    
    var differenceIdentifier: DifferenceIdentifier {
        return identifier
    }
    
    func isContentEqual(to source: TetrisRow) -> Bool {
        return source.identifier == identifier
    }
}

extension TetrisBlock: Differentiable {
    typealias DifferenceIdentifier = Int
    
    var differenceIdentifier: DifferenceIdentifier {
        return identifier
    }
    
    func isContentEqual(to source: TetrisBlock) -> Bool {
        return source.identifier == identifier
    }
}
