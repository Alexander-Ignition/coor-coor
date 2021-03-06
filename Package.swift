// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "coor-coor",
    platforms: [
        .macOS(.v10_13),
    ],
    products: [
        .executable(name: "coor-coor", targets: ["CoorCoor"])
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime.git", from: "0.2.0"),
        .package(url: "https://github.com/swift-server/async-http-client", from: "1.0.0"),
    ],
    targets: [
        .target(name: "CoorCoor", dependencies: [
            .product(name: "AWSLambdaRuntime", package: "swift-aws-lambda-runtime"),
            .product(name: "AWSLambdaEvents", package: "swift-aws-lambda-runtime"),
            .product(name: "AsyncHTTPClient", package: "async-http-client"),
        ]),
    ]
)
