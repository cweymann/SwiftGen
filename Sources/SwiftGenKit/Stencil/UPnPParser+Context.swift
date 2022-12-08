//
// SwiftGenKit
// Copyright © 2022 SwiftGen
// MIT Licence
//

import Foundation
extension UPnP.Parser {
	public func stencilContext() -> [String: Any] {
		let services = self.services
			.sorted { lhs, rhs in lhs.name < rhs.name }
			.map(map(service:))
		return [
			"services": services
		]
	}

	private func map(service: UPnP.Service) -> [String: Any] {
		var result: [String: Any] = [
			"name": service.name,
			"actions": service.actions
				.sorted { $0.name < $1.name }
				.map(map(action:))
		]
		return result
	}

	private func map(action: UPnP.Action) -> [String: Any] {
		var result: [String: Any] = [
			"name": action.name
		]
		return result
	}
}

