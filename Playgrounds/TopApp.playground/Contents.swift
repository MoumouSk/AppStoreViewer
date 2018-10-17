import UIKit
import PlaygroundSupport

public protocol DataFetching {
    func fetchData(url: URL, completion: @escaping (Data?, Error?) -> Void)
}

extension DataFetching {
    public func fetchData(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }.resume()
    }
}

public struct App {
    
    let name: String
    let summary: String
    let thumbImageUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "im:name"
        case summary
        case image = "im:image"
    }
    
    private enum LabelKeys: String, CodingKey {
        case label
    }
    
    var tempThumbImageUrl = ""
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nameContainer = try container.nestedContainer(keyedBy: LabelKeys.self, forKey: .name)
        let summaryContainer = try container.nestedContainer(keyedBy: LabelKeys.self, forKey: .summary)
        var imagesContainer = try container.nestedUnkeyedContainer(forKey: .image)
        name = try nameContainer.decode(String.self, forKey: .label)
        summary = try summaryContainer.decode(String.self, forKey: .label)
        
        while !imagesContainer.isAtEnd {
            let imageContainer = try imagesContainer.nestedContainer(keyedBy: LabelKeys.self)
            tempThumbImageUrl = try imageContainer.decode(String.self, forKey: LabelKeys.label)
            break
        }
        thumbImageUrl = tempThumbImageUrl
    }
}

extension App: Decodable {}

extension App: Listable {
    public var text: String {
        return name
    }
    public var longText: String {
        return summary
    }
}

public class AppStoreRessources : DataFetching {
    
    private struct ServerResponse: Decodable {
        let feed: Feed
    }
    
    private struct Feed: Decodable {
        let entry: [App]
    }
    
    public func getTopApps(top: Int, completion: @escaping ([App], Error?) -> Void) {

        let urlString = "https://itunes.apple.com/fr/rss/toppaidapplications/limit=\(top)/json"
        let url = URL(string: urlString)
        
        fetchData(url: url!) { (data, dataError) in
            var apps = [App]()
            var parseError = dataError
            
            defer {
                completion(apps, parseError)
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let serverResponse = try jsonDecoder.decode(ServerResponse.self, from: data)
                apps = serverResponse.feed.entry
            }
            catch {
                parseError = error
            }

        }
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
