//
// SwiftGenKit
// Copyright © 2022 SwiftGen
// MIT Licence
//

import Foundation
import Kanna

extension UPnP {
	struct State {
		let name: String
		let dataType: DataType
		let defaultValue: String?
	}
}

// MARK: - XML

private enum XML {
	static let nameXPath = "//u:name"
	static let dataTypeXPath = "//u:dataType"
	static let defaultValueXPath = "//u:defaultValue"
}

extension UPnP.State {
	enum DataType: String {
		case unknown
		case string
		case ui4
		case ui2
	}
	init(with object: Kanna.XMLElement) {
		name = object.xpath(XML.nameXPath, namespaces: UPnP.namespaces).first?.content ?? ""
		let rawDataType = object.xpath(XML.dataTypeXPath, namespaces: UPnP.namespaces).first?.content ?? "unknown"
		dataType = DataType(rawValue: rawDataType) ?? .unknown
		defaultValue = object.xpath(XML.defaultValueXPath, namespaces: UPnP.namespaces).first?.content
	}
}

// MARK: - Hashable

extension UPnP.State: Equatable {}
extension UPnP.State: Hashable {}

