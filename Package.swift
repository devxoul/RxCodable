// swift-tools-version:5.0

import PackageDescription

let package = Package(
  name: "RxCodable",
  platforms: [
    .macOS(.v10_11), .iOS(.v8), .tvOS(.v9), .watchOS(.v3)
  ],
  products: [
    .library(name: "RxCodable", targets: ["RxCodable"]),
  ],
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.0")),
  ],
  targets: [
    .target(name: "RxCodable", dependencies: ["RxSwift"]),
    .target(name: "TestUtil", dependencies: ["RxCodable", "RxBlocking"]),
    .testTarget(name: "RxCodableTests", dependencies: ["RxCodable", "TestUtil"]),
  ]
)
