//
//  HighlightViewController.swift
//  Highlight
//
//  Created by Jonathan Provo on 07/11/2022.
//

import UIKit

public final class HighlightViewController: UIViewController {
	// MARK: - Types

	public struct Options {
		public var backgroundColor: UIColor
		public var backgroundOpacity: Float

		public init(backgroundColor: UIColor = .black, backgroundOpacity: Float = 0.5) {
			self.backgroundColor = backgroundColor
			self.backgroundOpacity = backgroundOpacity
		}
	}

	// MARK: - Properties

	private var highlights: [Highlight] = []
	private var options: Options = .init()

	// MARK: - Lifecycle

	convenience init(highlights: [Highlight], options: Options? = nil) {
		self.init(nibName: nil, bundle: nil)
		self.highlights = highlights
		self.options = options ?? self.options
	}

	public override func viewDidLoad() {
		super.viewDidLoad()
		addGestures()
		addNextHighlight()
	}

	// MARK: - Gestures

	private func addGestures() {
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss(_:))))
	}

	// MARK: - Highlights

	private func addNextHighlight() -> Bool {
		guard !highlights.isEmpty else { return false }
		removeAll()
		addHighlight(highlight: highlights.removeFirst())
		return true
	}

	private func removeAll() {
		view.subviews.forEach { $0.removeFromSuperview() }
		view.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
	}

	private func addHighlight(highlight: Highlight) {
		let path: UIBezierPath = .init(rect: view.bounds)
		path.append(highlight.path)
		path.usesEvenOddFillRule = true

		let layer: CAShapeLayer = .init()
		layer.fillColor = options.backgroundColor.cgColor
		layer.fillRule = .evenOdd
		layer.opacity = options.backgroundOpacity
		layer.path = path.cgPath
		view.layer.addSublayer(layer)

		let border = addBorder(highlight: highlight)
		addText(highlight: highlight, relativeTo: border)
	}

	private func addBorder(highlight: Highlight) -> UIView {
		let frame: CGRect = highlight.frame
		let border: UIView = highlight.view
		border.layer.borderColor = highlight.options.borderColor.cgColor
		border.layer.borderWidth = highlight.options.borderWidth
		view.addSubview(border)
		NSLayoutConstraint.activate([
			border.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: frame.origin.x),
			border.topAnchor.constraint(equalTo: view.topAnchor, constant: frame.origin.y)
		])
		return border
	}

	private func addText(highlight: Highlight, relativeTo border: UIView) {
		let label: UILabel = highlight.label
		view.addSubview(label)
		var layoutConstraints: [NSLayoutConstraint] = []

		switch highlight.options.textPosition.horizontalAlignment {
		case .left:
			if highlight.options.textPosition.verticalAlignment == .center {
				layoutConstraints.append(label.trailingAnchor.constraint(equalTo: border.leadingAnchor, constant: -highlight.options.textOffset.x))
			} else {
				layoutConstraints.append(label.leadingAnchor.constraint(equalTo: border.leadingAnchor, constant: highlight.options.textOffset.x))
			}
		case .center:
			layoutConstraints.append(label.centerXAnchor.constraint(equalTo: border.centerXAnchor, constant: highlight.options.textOffset.x))
		case .right:
			if highlight.options.textPosition.verticalAlignment == .center {
				layoutConstraints.append(label.leadingAnchor.constraint(equalTo: border.trailingAnchor, constant: highlight.options.textOffset.x))
			} else {
				layoutConstraints.append(label.trailingAnchor.constraint(equalTo: border.trailingAnchor, constant: -highlight.options.textOffset.x))
			}
		}

		switch highlight.options.textPosition.verticalAlignment {
		case .top:
			layoutConstraints.append(label.bottomAnchor.constraint(equalTo: border.topAnchor, constant: -highlight.options.textOffset.y))
		case .center:
			layoutConstraints.append(label.centerYAnchor.constraint(equalTo: border.centerYAnchor, constant: highlight.options.textOffset.y))
		case .bottom:
			layoutConstraints.append(label.topAnchor.constraint(equalTo: border.bottomAnchor, constant: highlight.options.textOffset.y))
		}

		layoutConstraints.forEach { $0.priority = .defaultHigh }
		layoutConstraints.append(label.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor))
		layoutConstraints.append(label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor))
		layoutConstraints.append(label.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor))
		layoutConstraints.append(label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor))
		NSLayoutConstraint.activate(layoutConstraints)
	}

	// MARK: - Presentation

	@objc
	private func dismiss(_ sender: UITapGestureRecognizer) {
		guard sender.state == .ended else { return }
		guard !addNextHighlight() else { return }
		dismiss(animated: true)
	}
}
