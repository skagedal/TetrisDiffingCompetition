//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

private func adapters() -> [TetrisAdapter] {
    if #available(iOS 13, *) {
        return [
            SKRBatchUpdatesTetrisAdapter(),
            UICollectionViewDiffableDataSourceTetrisAdapter(),
            DifferenceKitTetrisAdapter(),
            DwifftTetrisAdapter(),
            DifferTetrisAdapter()
        ]
    } else {
        return [
            SKRBatchUpdatesTetrisAdapter(),
            DifferenceKitTetrisAdapter(),
            DwifftTetrisAdapter(),
            DifferTetrisAdapter()
        ]
    }
}

class RootViewController: UIViewController {
    private lazy var menu = MenuViewController(adapters: adapters())
    
    private lazy var navigation: UINavigationController = {
        let navigation = UINavigationController(rootViewController: menu)
        navigation.isToolbarHidden = false
        return navigation
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menu.delegate = self
        embed(navigation)
    }
    
    private func makeGameViewController(with adapter: TetrisAdapter) -> TetrisViewController {
        return TetrisViewController.instantiate(with: adapter)
    }
}

extension RootViewController: MenuViewControllerDelegate {
    func menuViewController(_ menuViewController: MenuViewController, didSelect adapter: TetrisAdapter) {
        navigation.pushViewController(makeGameViewController(with: adapter), animated: true)
    }
}
