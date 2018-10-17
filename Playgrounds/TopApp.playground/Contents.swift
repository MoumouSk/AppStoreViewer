import UIKit
import PlaygroundSupport
@testable import AppStoreViewerFramework

extension App: Listable {
    public var text: String {
        return name
    }
    public var longText: String {
        return summary
    }
}

public protocol Listable {
    var text: String { get }
    var longText: String { get }
}

class AppsViewController: UITableViewController {
    
    public var apps = [Listable]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Default")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
        
        let app = apps[indexPath.row]
        cell.textLabel?.text = app.text
        
        return cell
    }
}

let appsViewController = AppsViewController()
let ressource = AppStoreRessources()

ressource.getTopApps(top: 10) { (apps, error) in
    print(apps)
    print(error ?? "Clean")
    appsViewController.apps = apps
}

PlaygroundPage.current.liveView = appsViewController
