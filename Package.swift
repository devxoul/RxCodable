// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "RxCodable",
  products: [
    .library(name: "RxCodable", targets: ["RxCodable"]),
    .library(name: "RxCodableMoya", targets: ["RxCodableMoya"]),
  ],
  dependencies: [
     .package(url: "https://github.com/ReactiveX/RxSwift.git", .branch("rxswift4.0-swift4.0")),
     .package(url: "https://github.com/Moya/Moya.git", .branch("10.0.0-dev")),
  ],
  targets: [
    .target(name: "RxCodable", dependencies: ["RxSwift"]),
    .target(name: "RxCodableMoya", dependencies: ["RxCodable", "Moya"]),
    .target(name: "TestUtil", dependencies: ["RxCodable", "RxBlocking"]),
    .testTarget(name: "RxCodableTests", dependencies: ["RxCodable", "TestUtil"]),
    .testTarget(name: "RxCodableMoyaTests", dependencies: ["RxCodableMoya", "TestUtil"]),
  ]
)
