import UIKit
import PlaygroundSupport

//public class ImageAndTextTableViewCell: UITableViewCell {
//
//    let stackView = UIStackView()
//    let label = UILabel()
//    let rightImageview = UIImageView()
//
//    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        commonInit()
//    }
//
//    public required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    private func commonInit() {
//
//        stackView.axis = .horizontal
//        stackView.alignment = .center
//        stackView.distribution = .fillProportionally
//        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//
//        stackView.spacing = 5
//        stackView.isLayoutMarginsRelativeArrangement = true
//
//        stackView.addArrangedSubview(label)
//        stackView.addArrangedSubview(rightImageview)
//
//        addSubview(stackView)
//    }
//
//    public override func layoutSubviews() {
//        super.layoutSubviews()
//
//        stackView.frame = bounds
//        backgroundColor = UIColor.red
//    }
//}

//let frame = CGRect(x: 0, y: 0, width: 320, height: 100)
//let cell = ImageAndTextTableViewCell(frame: frame)
//
//cell.frame = frame
//cell.label.text = "Coucou"
//let image = UIImage(named: "100x100bb-85.png")
//cell.rightImageview.image = image
//cell.rightImageview.contentMode = .scaleAspectFit
//PlaygroundPage.current.liveView = cell
