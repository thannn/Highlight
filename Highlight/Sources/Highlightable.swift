//
//  Highlight.swift
//  Alamofire
//
//  Created by Jonathan Provo on 07/11/2022.
//

import UIKit

public protocol Highlightable: AnyObject {
	func highlight(_ highlights: [Highlight], backgroundOptions: HighlightViewController.Options?)
}

public extension Highlightable where Self: UIViewController {
	func highlight(_ highlights: [Highlight], backgroundOptions: HighlightViewController.Options? = nil) {
		guard !highlights.isEmpty else { return }
		let highlightViewController: HighlightViewController = .init(highlights: highlights, options: backgroundOptions)
		highlightViewController.modalPresentationStyle = .overFullScreen
		highlightViewController.modalTransitionStyle = .crossDissolve
		present(highlightViewController, animated: true)
	}
}
