//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import Foundation

/// For use in required `init(coder:)` methods where this is not intended usage.
func unsupportedInitializer() -> Never {
    fatalError("This view cannot be initialized from a storyboard or nib.")
}
