//
// SwiftGenKit
// Copyright © 2022 SwiftGen
// MIT Licence
//

import Foundation
import Kanna

extension UPnP {
  struct Action {
    let name: String
	let arguments: Set<Argument>
  }
}

// MARK: - XML

private enum XML {
	static let nameXPath = "//u:name"
	static let argumentsXPath = "//u:argumentList/u:argument"
}

extension  UPnP.Action {
	init(with object: Kanna.XMLElement) {
		name = object.xpath(XML.nameXPath, namespaces: UPnP.namespaces).first?.content ?? ""
		arguments = Set<UPnP.Argument>(
			object.xpath(XML.argumentsXPath, namespaces: UPnP.namespaces).compactMap { argument in
				return UPnP.Argument(with: argument)
			}
		)
	}
}

// MARK: - Hashable

extension UPnP.Action: Equatable {}
extension UPnP.Action: Hashable {}
