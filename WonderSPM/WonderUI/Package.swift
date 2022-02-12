// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WonderUI",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "WonderUI",
            targets: ["WonderUI"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "PinLayout", url: "https://github.com/layoutBox/Pinlayout", .exact("1.10.0")),
        .package(name: "Kingfisher", url: "https://github.com/onevcat/Kingfisher", .exact("7.1.2")),
        .package(name: "WonderResources", path: "../WonderResources"),
        .package(name: "WonderNetwork", path: "../WonderNetwork"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "WonderUI",
            dependencies: [
                "PinLayout",
                "Kingfisher",
                "WonderNetwork",
                "WonderResources"
            ],
            resources: [.process("Resources")]),
        .testTarget(
            name: "WonderUITests",
            dependencies: ["WonderUI"]),
    ],
    swiftLanguageVersions: [.v5]
)
