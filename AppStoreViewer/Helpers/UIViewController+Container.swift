//
//  UIViewController+Container.swift
//  Tools
//
//  Created by Gil Nakache on 11/12/2017.
//  Copyright © 2016 Viseo. All rights reserved.
//

import UIKit

/// Extension used to facilitate adding child viewControllers in a viewController
public extension UIViewController
{
    /// Embeds a view controller and also adds it's view in the view hierarchay
    ///
    /// - Parameter viewController: ViewController to add
    public func add(asChildViewController viewController: UIViewController, anchored: Bool = true, subview: UIView? = nil)
    {
        let someView: UIView = subview ?? view

        // Notify Child View Controller before
        viewController.willMove(toParent: self)

        // Add Child View Controller
        addChild(viewController)

        // Add Child View as Subview
        someView.addSubview(viewController.view)

        if anchored
        {
            // Embeded viewControllers should not use safeAnchors
            anchor(view: viewController.view, useSafeAnchors: false)
        }

        // Notify Child View Controller after
        viewController.didMove(toParent: self)
    }

    /// Removes a view controller from both view controller and view hierachies
    ///
    /// - Parameter viewControllerToRemove: ViewController to remove
    public func remove(viewControllerToRemove: UIViewController?)
    {
        guard let viewController = viewControllerToRemove else
        {
            return
        }

        // Notify Child View Controller before
        viewController.willMove(toParent: nil)

        // Remove View
        viewController.view.removeFromSuperview()

        // Remove ViewController
        viewController.removeFromParent()

        // Notify Child View Controller after
        viewController.didMove(toParent: nil)
    }
}
