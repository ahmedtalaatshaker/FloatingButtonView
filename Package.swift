// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FloatingButtonView",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FloatingButtonView",
            targets: ["FloatingButtonView"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.0.0")
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "FloatingButtonView",
            dependencies: ["RxSwift",
                           .product(name: "RxCocoa", package: "RxSwift")],
            path: "Sources"),
        .testTarget(
            name: "FloatingButtonViewTests",
            dependencies: ["FloatingButtonView"]),
    ]
)
