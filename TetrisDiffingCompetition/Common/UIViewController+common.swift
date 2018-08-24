//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

extension UIViewController {
    func embed(_ childViewController: UIViewController) {
        embed(childViewController, in: self.view)
    }
    
    func embed(_ childViewController: UIViewController, in embeddingView: UIView) {
        addChildViewController(childViewController)
        
        let subview = childViewController.view!
        embeddingView.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: embeddingView.leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: embeddingView.trailingAnchor),
            subview.topAnchor.constraint(equalTo: embeddingView.topAnchor),
            subview.bottomAnchor.constraint(equalTo: embeddingView.bottomAnchor)
        ])
        
        childViewController.didMove(toParentViewController: self)
    }
    
}
