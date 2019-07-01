//
//  Copyright © 2017 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

class TetrisViewController: UIViewController {
    @IBOutlet private var collectionView: UICollectionView!
    
    private var adapter: TetrisAdapter!
    private var game = TetrisGame()
    private var timer: Timer?
    
    // MARK: Life cycle
    
    static func instantiate(with adapter: TetrisAdapter) -> TetrisViewController {
        let viewController = UIStoryboard(name: "Tetris", bundle: nil).instantiateInitialViewController() as! TetrisViewController
        viewController.adapter = adapter
        viewController.navigationItem.title = adapter.name
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        adapter.configure(collectionView: collectionView) { collectionView, indexPath in
            collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        }
        adapter.setBoard(game.currentBoard)
    }

    // MARK: Actions
    
    @IBAction private func play(_ sender: Any) {
        startGame()
    }
    
    @IBAction private func moveLeft(_ sender: UIBarButtonItem) {
        if game.left() {
            update()
        }
    }
    
    @IBAction private func moveRight(_ sender: UIBarButtonItem) {
        if game.right() {
            update()
        }
    }
    
    @IBAction private func rotateLeft(_ sender: UIBarButtonItem) {
        if game.rotateLeft() {
            update()
        }
    }
    
    @IBAction private func rotateRight(_ sender: UIBarButtonItem) {
        if game.rotateRight() {
            update()
        }
    }
    
    @IBAction private func drop(_ sender: UIBarButtonItem) {
        if game.drop() {
            stopTimer()
            update(completion: { _ in
                self.startTimer()
            })
        }
    }
    
    // Game logic
    
    private func startGame() {
        game = TetrisGame()
        spawnOrGameOver()
        startTimer()
    }
    
    private func tick() {
        if game.down() {
            update()
        } else {
            game.fixBlock()
            if game.removeLines() {
                update()
            }
            spawnOrGameOver()
        }
    }

    private func spawnOrGameOver() {
        if game.spawn() {
            update()
        } else {
            gameOver()
        }
    }
    
    private func gameOver() {
        stopTimer()
    }
    
    private func update(completion: ((Bool) -> Swift.Void)? = nil) {
        adapter.animateBoard(to: game.currentBoard, completion: completion)
    }

    private func startTimer() {
        if let timer = self.timer {
            timer.invalidate()
        }
        let timer = Timer(fire: Date(), interval: 0.5, repeats: true) {_ in
            self.tick()
        }
        RunLoop.current.add(timer, forMode: .default)
        self.timer = timer
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

extension UICollectionViewCell {
    func configure(with block: TetrisBlock) {
        switch block.type {
        case .empty:
            backgroundColor = .clear
            
        case .occupied(let color):
            backgroundColor = color
        }
    }
}
