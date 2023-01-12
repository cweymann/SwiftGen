//
// Templates UnitTests
// Copyright © 2022 SwiftGen
// MIT Licence
//

import TestUtils

final class UPnPTests: InterfaceBuilderTests {
  func testSwift5() {
    test(
      template: "swift5",
      contextNames: ["all"],
      directory: .upnp,
      resourceDirectory: .upnp,
      contextVariations: nil
    )
  }
}
