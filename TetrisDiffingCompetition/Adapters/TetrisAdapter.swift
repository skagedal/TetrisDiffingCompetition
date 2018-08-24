//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

protocol TetrisAdapter {
    var name: String { get }
    func makeGameViewController() -> UIViewController
}
