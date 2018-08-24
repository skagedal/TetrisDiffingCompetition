//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    private lazy var menu = MenuViewController(adapters: [
        SKRBatchUpdatesTetrisAdapter()
    ])
    
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
}

extension RootViewController: MenuViewControllerDelegate {
    func menuViewController(_ menuViewController: MenuViewController, didSelect adapter: TetrisAdapter) {
        navigation.pushViewController(adapter.makeGameViewController(), animated: true)
    }
}
