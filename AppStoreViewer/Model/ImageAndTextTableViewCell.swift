//
//  ImageAndTableViewCell.swift
//  AppStoreViewer
//
//  Created by Tom Hays on 17/10/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import Foundation

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
}
