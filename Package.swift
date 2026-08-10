// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SwiftEntryKit",
  platforms: [
    // Raised from .v9: Xcode 27 refuses any deployment target below iOS 15,
    // and CollaNote is on 15.0 anyway.
    .iOS(.v15)
  ],
  products: [
    .library(name: "SwiftEntryKit", targets: ["SwiftEntryKit"])
  ],
  targets: [
    .target(
      name: "SwiftEntryKit",
      path: "Source"
    )
  ],
  swiftLanguageVersions: [
    .v5
  ]
)
