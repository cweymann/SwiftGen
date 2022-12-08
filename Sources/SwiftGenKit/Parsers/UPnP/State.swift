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
    let dataType: String
    let dataValue: String
  }
}

// MARK: - XML

private enum XML {
  static let customClassAttribute = "customClass"
  static let customModuleAttribute = "customModule"
  static let customModuleProviderAttribute = "customModuleProvider"
  static let storyboardIdentifierAttribute = "storyboardIdentifier"
  static let targetValue = "target"
}

extension UPnP.State {
	init(with object: Kanna.XMLElement) {
		name = object.tagName ?? ""
		dataType = object[XML.customClassAttribute] ?? ""
		dataValue = object[XML.customModuleAttribute] ?? ""
	}
}

// MARK: - Hashable

extension UPnP.State: Equatable {}
extension UPnP.State: Hashable {}
