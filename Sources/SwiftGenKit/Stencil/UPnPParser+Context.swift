//
// SwiftGenKit
// Copyright © 2022 SwiftGen
// MIT Licence
//

import Foundation
extension UPnP.Parser {
	public func stencilContext() -> [String: Any] {
		let device = self.device
		let services = self.services
			.sorted { lhs, rhs in lhs.name < rhs.name }
			.map(map(service:))
		return [
			"device": device.map(map(device:)) ?? "",
			"services": services
		]
	}
	private func map(device: UPnP.Device) -> [String: Any] {
		let result: [String: Any] = [
			"friendlyName": device.friendlyName,
			"services": device.services
				.sorted { $0.serviceId < $1.serviceId }
				.map(map(serviceStub:)),
			"childDevices": device.childDevices
				.sorted{ $0.friendlyName < $1.friendlyName }
				.map(map(device:))
		]
		return result
	}
	private func map(serviceStub: UPnP.ServicePlaceholder) -> [String: Any] {
		let result: [String: Any] = [
			"scpdURL": serviceStub.scpdURL
		]
		return result
	}
	private func map(service: UPnP.Service) -> [String: Any] {
		let result: [String: Any] = [
			"name": mappedServiceName(service: service),
			"actions": service.actions
				.sorted { $0.name < $1.name }
				.map(map(action:)),
			"states": service.states
				.sorted{ $0.name < $1.name }
				.map(map(state:))
		]
		return result
	}

	private func mappedServiceName(service: UPnP.Service) -> String {
		let mappedName: String?
		switch service.name {
		case "deviceinfoSCPD":
			mappedName = "deviceInfo"
		case "deviceconfigSCPD":
			mappedName = "deviceConfig"
		default:
			mappedName = nil
		}
		return mappedName ?? service.name
	}

	private func map(action: UPnP.Action) -> [String: Any] {
		let result: [String: Any] = [
			"name": action.name,
			"arguments": action.arguments
				.sorted { $0.name < $1.name }
				.map(map(argument:))
		]
		return result
	}

	private func map(argument: UPnP.Argument) -> [String: Any] {
		let result: [String: Any] = [
			"name": argument.name,
			"direction": argument.direction.rawValue,
			"relatedStateName": argument.relatedStateName
		]
		return result
	}

	private func map(state: UPnP.State) -> [String: Any] {
		var result: [String: Any] = [
			"name": state.name,
			"dataType": state.dataType.rawValue
		]
		if let defaultValue = state.defaultValue {
			result["defaultValue"] = defaultValue
		}
		return result
	}
}

