//
//  ServicePlaceholder.swift
//  
//
//  Created by Claus Weymann on 09.01.23.
//

import Foundation
import Kanna

extension UPnP {
	struct ServicePlaceholder: Hashable {
		let serviceType: String
		let serviceId: String
		let controlURL: String
		let eventSubURL: String
		let scpdURL: String
	}
}

// MARK: - XML

private enum XML {
	static let serviceTypeXPath = "//u:serviceType"
	static let serviceIdXPath = "//u:serviceId"
	static let controlURLXPath = "//u:controlURL"
	static let eventSubURLXPath = "//u:eventSubURL"
	static let scpdURLXPath = "//u:SCPDURL"
}

extension UPnP.ServicePlaceholder {
	init(with object: Kanna.XMLElement, namespace: String) {
		let namespaces = ["u":namespace]
		self.serviceType = object.xpath(XML.serviceTypeXPath, namespaces: namespaces).first?.content ?? ""
		self.serviceId = object.xpath(XML.serviceIdXPath, namespaces: namespaces).first?.content ?? ""
		self.controlURL = object.xpath(XML.controlURLXPath, namespaces: namespaces).first?.content ?? ""
		self.eventSubURL = object.xpath(XML.eventSubURLXPath, namespaces: namespaces).first?.content ?? ""
		self.scpdURL = object.xpath(XML.scpdURLXPath, namespaces: namespaces).first?.content ?? ""
	}
}
