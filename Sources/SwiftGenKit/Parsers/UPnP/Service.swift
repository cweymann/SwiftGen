//
// SwiftGenKit
// Copyright © 2022 SwiftGen
// MIT Licence
//

import Foundation
import Kanna

extension UPnP {
	struct Service {
		let name: String
		let actions: Set<Action>
		let states: Set<State>
	}
}

// MARK: - XML

private enum XML {
	static let actionXPath = "//u:action"
	static let stateXPath = "//u:stateVariable"

	static let placeholderTags = ["controllerPlaceholder", "viewControllerPlaceholder"]
}

extension UPnP.Service {
	init(with document: Kanna.XMLDocument, name: String) throws {
		self.name = name

		// Actions
		actions = Set<UPnP.Action>(
			document.xpath(XML.actionXPath, namespaces: UPnP.namespaces).compactMap { element in
				guard !XML.placeholderTags.contains(element.tagName ?? "") else { return nil }
				return UPnP.Action(with: element)
			}
		)

		// States
		states = Set<UPnP.State>(
			document.xpath(XML.stateXPath).map { element in
				UPnP.State(with: element)
			}
		)
	}
}

