//
//  Highlight.swift
//  Highlight
//
//  Created by Jonathan Provo on 07/11/2022.
//

import UIKit

public struct Highlight {
	// MARK: - Types
	
	public struct Options {
		public enum CornerRadius {
			/// An absolute corner radius.
			case absolute(value: CGFloat)
			/// A relative corner radius, 0 represents no corner radius, 1 represent a corner radius equal to half the height.
			case relative(value: CGFloat)

			func value(forHeight height: CGFloat) -> CGFloat {
				switch self {
				case .absolute(let value):
					return value
				case .relative(let value):
					return (height / 2) * max(0, min(value, 1))
				}
			}
		}

		public struct TextPosition {
			public enum HorizontalAlignment {
				/// Aligns text and highlight on the left side.
				case left
				/// Centers text and highlight.
				case center
				/// Aligns text and highlight on the right side.
				case right
			}
			public enum VerticalAlignment {
				/// Aligns text above the highlight.
				case top
				/// Centers text and highlight.
				case center
				/// Aligns text below the highlight.
				case bottom
			}

			let horizontalAlignment: HorizontalAlignment
			let verticalAlignment: VerticalAlignment

			public init(horizontalAlignment: HorizontalAlignment, verticalAlignment: VerticalAlignment) {
				self.horizontalAlignment = horizontalAlignment
				self.verticalAlignment = verticalAlignment
			}
		}

		public var borderColor: UIColor = .clear
		public var borderWidth: CGFloat = 0
		public var cornerRadius: CornerRadius = .absolute(value: 0)
		public var insets: UIEdgeInsets = .zero
		public var textBackgroundColor: UIColor = .white
		public var textColor: UIColor = .black
		public var textCornerRadius: CornerRadius = .absolute(value: 0)
		public var textFont: UIFont = .systemFont(ofSize: 14, weight: .regular)
		public var textInsets: UIEdgeInsets = .zero
		public var textNumberOfLines: Int = 0
		public var textOffset: CGPoint = .zero
		public var textPosition: TextPosition = .init(horizontalAlignment: .center, verticalAlignment: .bottom)

		public init() {
		}
	}

	// MARK: - Properties
	
	private let frameWithoutInsets: CGRect
	let text: String
	let options: Options
	var frame: CGRect {
		let x: CGFloat = frameWithoutInsets.origin.x - options.insets.left
		let y: CGFloat = frameWithoutInsets.origin.y - options.insets.top
		let width: CGFloat = frameWithoutInsets.width + options.insets.left + options.insets.right
		let height: CGFloat = frameWithoutInsets.height + options.insets.top + options.insets.bottom
		return .init(x: x, y: y, width: width, height: height)
	}

	// Returns a label representing the text of this highlight.
	var label: UILabel {
		let label: HighlightLabel = .init(edgeInsets: options.textInsets)
		label.backgroundColor = options.textBackgroundColor
		label.clipsToBounds = true
		label.font = options.textFont
		label.layer.cornerRadius = options.textCornerRadius.value(forHeight: label.intrinsicContentSize.height)
		label.layer.zPosition = 1
		label.numberOfLines = options.textNumberOfLines
		label.text = text
		label.textColor = options.textColor
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}

	// Returns a path representing the area of this highlight.
	var path: UIBezierPath {
		let frame = frame
		return .init(roundedRect: frame, cornerRadius: options.cornerRadius.value(forHeight: frame.height))
	}

	// Returns a view representing the area of this highlight.
	var view: UIView {
		let frame = frame
		let view: UIView = .init(frame: .zero)
		view.isUserInteractionEnabled = false
		view.layer.cornerRadius = options.cornerRadius.value(forHeight: frame.height)
		view.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			view.widthAnchor.constraint(equalToConstant: frame.width),
			view.heightAnchor.constraint(equalToConstant: frame.height)
		])
		return view
	}

	// MARK: - Lifecycle

	/// Creates a highlight. Returns `nil` when `view` is not part of the view hierarchy.
	public init?(view: UIView, text: String, options: Highlight.Options) {
		guard let superview = view.superview else { return nil }
		frameWithoutInsets = superview.convert(view.frame, to: nil)
		self.options = options
		self.text = text
	}

	/// Creates a highlight. `frame` should be in window based coordinates.
	public init(frame: CGRect, text: String, options: Highlight.Options) {
		frameWithoutInsets = frame
		self.options = options
		self.text = text
	}
}
