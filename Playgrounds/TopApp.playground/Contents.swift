import UIKit
import PlaygroundSupport
@testable import AppStoreViewerFramework

public class ImageAndTextTableViewCell: UITableViewCell {
    
    let stackView = UIStackView()
    let label = UILabel()
    let rightImageview = UIImageView()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        label.numberOfLines = 2
        stackView.axis = .horizontal
       
        stackView.distribution = .fillProportionally
        
        stackView.alignment = .center
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        stackView.spacing = 5
        stackView.isLayoutMarginsRelativeArrangement = true
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(rightImageview)
        
        addSubview(stackView)
        
        anchor(view: stackView)
        
    }
    
//    public override func layoutSubviews() {
//        super.layoutSubviews()
//
//       stackView.frame = bounds
//    }
}

extension App: Listable {
    public var text: String {
        return name
    }
    public var longText: String {
        return summary
    }
    public var imageUrl: String {
        return thumbImageUrl
    }
}

public protocol Listable {
    var text: String { get }
    var longText: String { get }
    var imageUrl: String { get }
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
            
            let url = URL(string: app.imageUrl)
            
            URLSession.shared.dataTask(with: url!) { data, _, _ in
                guard let data = data else { return }
                
                print(data)
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    
                    imageCell.rightImageview.image = image
                    imageCell.rightImageview.contentMode = .scaleAspectFit
//                    imageCell.setNeedsUpdateConstraints()
                    }
                }.resume()
        }
        return cell
    }
}

let appsViewController = AppsViewController()
let ressource = AppStoreRessources()

ressource.getTopApps(top: 100) { (apps, error) in
    print(apps)
    print(error ?? "Clean")
    appsViewController.apps = apps
}

PlaygroundPage.current.liveView = appsViewController
