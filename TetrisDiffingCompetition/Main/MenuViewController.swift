//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class MenuViewController: UITableViewController {
    weak var delegate: MenuViewControllerDelegate?
    
    private let adapters: [TetrisAdapter]

    init(adapters: [TetrisAdapter]) {
        self.adapters = adapters
        
        super.init(style: .grouped)
        
        navigationItem.title = "The Tetris Diffing Competition"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: nil, action: nil)
    }

    required init?(coder aDecoder: NSCoder) { unsupportedInitializer() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SubtitleCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adapters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let a = adapter(for: indexPath)
        cell.textLabel?.text = a.name
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.textColor = UIColor(white: 0, alpha: 0.8)
        cell.detailTextLabel?.text = a.comment
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.menuViewController(self, didSelect: adapter(for: indexPath))
    }
    
    private func adapter(for indexPath: IndexPath) -> TetrisAdapter {
        return adapters[indexPath.row]
    }
}

protocol MenuViewControllerDelegate: AnyObject {
    func menuViewController(_ menuViewController: MenuViewController, didSelect adapter: TetrisAdapter)
}

final class SubtitleCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) { unsupportedInitializer() }
}
