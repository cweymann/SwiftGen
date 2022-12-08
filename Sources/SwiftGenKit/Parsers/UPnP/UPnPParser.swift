//
// SwiftGenKit
// Copyright © 2022 SwiftGen
// MIT Licence
//

import Foundation
import Kanna
import PathKit

public enum UPnP {
	public static let namespaces = ["u":"urn:dslforum-org:service-1-0"]
	public enum ParserError: Error, CustomStringConvertible {
		case invalidFile(path: Path, reason: String)
		case unsupportedTargetRuntime(target: String)

		public var description: String {
			switch self {
			case .invalidFile(let path, let reason):
				return "error: Unable to parse file at \(path). \(reason)"
			case .unsupportedTargetRuntime(let target):
				return "Unsupported target runtime `\(target)`."
			}
		}
	}

	public final class Parser: SwiftGenKit.Parser {

		private let options: ParserOptionValues
		var services = [Service]()
		public var warningHandler: Parser.MessageHandler?

		public init(options: [String: Any] = [:], warningHandler: Parser.MessageHandler? = nil) throws {
			self.options = try ParserOptionValues(options: options, available: Self.allOptions)
			self.warningHandler = warningHandler
		}

		public static let defaultFilter = filterRegex(forExtensions: ["xml"])

		public func parse(path: Path, relativeTo parent: Path) throws {
			try addService(at: path)
		}

		func addService(at path: Path) throws {
			do {
				let document = try Kanna.XML(xml: path.read(), encoding: .utf8)

				let name = path.lastComponentWithoutExtension
				let service = try Service(with: document, name: name)
				services += [service]
			} catch let error {
				throw ParserError.invalidFile(path: path, reason: "XML parser error: \(error).")
			}
		}
	}
}
