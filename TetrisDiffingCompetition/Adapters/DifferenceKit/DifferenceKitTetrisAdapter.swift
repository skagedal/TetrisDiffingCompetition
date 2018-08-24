//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit
import DifferenceKit

class DifferenceKitTetrisAdapter: TetrisAdapter {
    let name = "DifferenceKit"

    private var sections: [ArraySection<TetrisRow, TetrisBlock>] = []
    
    func setBoard(_ tetrisBoard: TetrisBoard) {
        sections = tetrisBoard.sections
    }
    
    func animateBoard(to board: TetrisBoard, in collectionView: UICollectionView, completion: ((Bool) -> Void)?) {
        let changes = StagedChangeset(source: sections, target: board.sections)
        collectionView.reload(using: changes, setData: { newSections in
            self.sections = newSections
        })
        // Since DifferenceKit does not let us provide completion block
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            completion?(true)
        }
    }

    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return sections[section].elements.count
    }
    
    func tetrisBlock(for indexPath: IndexPath) -> TetrisBlock {
        return sections[indexPath.section].elements[indexPath.row]
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
