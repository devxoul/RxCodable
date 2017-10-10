// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "RxCodable",
  products: [
    .library(name: "RxCodable", targets: ["RxCodable"]),
  ],
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "4.0.0-rc.0")),
  ],
  targets: [
    .target(name: "RxCodable", dependencies: ["RxSwift"]),
    .target(name: "TestUtil", dependencies: ["RxCodable", "RxBlocking"]),
    .testTarget(name: "RxCodableTests", dependencies: ["RxCodable", "TestUtil"]),
  ]
)
