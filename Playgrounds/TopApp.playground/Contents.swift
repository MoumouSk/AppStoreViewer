import UIKit
import PlaygroundSupport
@testable import AppStoreViewerFramework 

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
        tableView.register(ImageAndTextTableViewCell.self, forCellReuseIdentifier: "Default")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
        let app = apps[indexPath.row]
        
        if let imageCell = cell as? ImageAndTextTableViewCell {
            imageCell.label.text = app.longText
            
            if let urlToFetch = URL(string: app.imageUrl) {
                app.fetchData(url: urlToFetch) { (data, error) in
                    if let data = data {
                        imageCell.rightImageview.image = UIImage(data: data)
                    }
                }
            }
            imageCell.rightImageview.contentMode = .scaleAspectFit
        }
        return cell
    }
}

let appsViewController = AppsViewController()
let ressource = AppStoreRessources()

ressource.getTopApps(top: 20) { (apps, error) in
    //print(error ?? "\(apps)\nApps loaded successfully")
    appsViewController.apps = apps
}

PlaygroundPage.current.liveView = appsViewController
