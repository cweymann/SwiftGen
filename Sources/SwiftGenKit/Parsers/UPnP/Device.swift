//
//  Device.swift
//  
//
//  Created by Claus Weymann on 09.01.23.
//

import Foundation
import Kanna

extension UPnP {
	struct Device: Hashable {
		let namespace: String
		let friendlyName: String
		let services: Set<ServicePlaceholder>
		let childDevices: Set<Device>

		func namespaces() -> [String: String] {
			return ["u":namespace]
		}
	}
}

// MARK: - XML

private enum XML {
	static let deviceElementXPath = "//u:device"
	static let friendlyNameXPath = "//u:friendlyName"
	static let serviceListElementXPath = "//u:serviceList/u:service"
	static let deviceListElementXPath = "//u:deviceList/u:device"
}

extension UPnP.Device {
	init(with document: Kanna.XMLDocument) throws {
		let namespace = UPnP.rootNamespace(from: document) ?? ""
		let namespaces = ["u":namespace]
		let deviceElement = document.at_xpath(XML.deviceElementXPath, namespaces: namespaces)
		self.init(with: deviceElement!, namespace: namespace)
	}

	init(with object: Kanna.XMLElement, namespace: String) {
		let namespaces = ["u":namespace]
		self.namespace = namespace

		
		self.friendlyName = object.xpath(XML.friendlyNameXPath, namespaces: namespaces).first?.content ?? ""

		services = Set<UPnP.ServicePlaceholder>(
			object.xpath(XML.serviceListElementXPath, namespaces: namespaces).compactMap { element in
				return UPnP.ServicePlaceholder(with: element, namespace: namespace)
			}
		)
		childDevices = Set<UPnP.Device>(
			object.xpath(XML.deviceListElementXPath, namespaces: namespaces).compactMap { element in
				return UPnP.Device(with: element, namespace: namespace)
			}
		)
	}
}
