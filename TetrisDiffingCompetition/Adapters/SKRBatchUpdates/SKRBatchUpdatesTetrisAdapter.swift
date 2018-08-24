//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

class SKRBatchUpdatesTetrisAdapter: TetrisAdapter {
    let name = "SKRBatchUpdates"
    func makeGameViewController() -> UIViewController {
        return UIStoryboard(name: "Tetris", bundle: nil).instantiateInitialViewController()!
    }
}
