//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

protocol TetrisAdapter {
    var name: String { get }
    var collectionView: UICollectionView? { get set }
    
    func setBoard(_ tetrisBoard: TetrisBoard)
    func animateBoard(to board: TetrisBoard, in collectionView: UICollectionView, completion: ((Bool) -> Void)?)

    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func tetrisBlock(for indexPath: IndexPath) -> TetrisBlock
}
