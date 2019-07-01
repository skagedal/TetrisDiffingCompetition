//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

protocol TetrisAdapter {
    var name: String { get }
    var comment: String { get }
    
    func configure(collectionView: UICollectionView, cellProvider: @escaping (UICollectionView, IndexPath) -> UICollectionViewCell)
    
    func setBoard(_ tetrisBoard: TetrisBoard)
    func animateBoard(to board: TetrisBoard, completion: ((Bool) -> Void)?)
}
