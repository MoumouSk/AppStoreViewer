//
//  ReusableView.swift
//  Tools
//
//  Created by Gil Nakache on 28/02/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//  Pasted from https://gist.github.com/gonzalezreal/92507b53d2b1e267d49a

import UIKit

public protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UICollectionViewCell: ReusableView {
}

extension UITableViewCell: ReusableView {
}

extension UITableViewHeaderFooterView: ReusableView {
}
