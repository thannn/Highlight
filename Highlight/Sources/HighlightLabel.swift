//
//  HighlightLabel.swift
//  Highlight
//
//  Created by Jonathan Provo on 07/11/2022.
//

import UIKit

final class HighlightLabel: UILabel {
	// MARK: - Properties

	override var intrinsicContentSize: CGSize {
		let proposedIntrinsicContentSize = super.intrinsicContentSize
		return .init(width: proposedIntrinsicContentSize.width + edgeInsets.left + edgeInsets.right, height: proposedIntrinsicContentSize.height + edgeInsets.top + edgeInsets.bottom)
	}

	private var edgeInsets: UIEdgeInsets = .zero

	// MARK: - Lifecycle

	convenience init(edgeInsets: UIEdgeInsets) {
		self.init(frame: .zero)
		self.edgeInsets = edgeInsets
		self.textAlignment = .center
	}
}
