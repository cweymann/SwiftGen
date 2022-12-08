//
// SwiftGenKit
// Copyright © 2022 SwiftGen
// MIT Licence
//

import Foundation
import Kanna

extension UPnP {
	struct Argument {
		enum Direction {
			case `in`
			case out
		}
		let name: String
		let direction: Direction
		let relatedStateName: String
	}
}

// MARK: - XML

private enum XML {
	static let nameXPath = "//u:name"
	static let directionXPath = "//u:direction"
	static let relatedStateVariableXPath = "//u:relatedStateVariable"
}

extension  UPnP.Argument {
	init(with object: Kanna.XMLElement) {
		name = object.xpath(XML.nameXPath, namespaces: UPnP.namespaces).first?.content ?? ""
		direction = object.xpath(XML.directionXPath, namespaces: UPnP.namespaces).first?.content  == "out" ? .out : .in
		relatedStateName = object.xpath(XML.relatedStateVariableXPath, namespaces: UPnP.namespaces).first?.content ?? ""
	}
}

// MARK: - Hashable

extension UPnP.Argument: Equatable {}
extension UPnP.Argument: Hashable {}

