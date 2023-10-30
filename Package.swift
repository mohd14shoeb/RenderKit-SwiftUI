// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RENDERKit",
    platforms: [
          .iOS(.v15)
      ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RENDERKit",
            targets: ["RENDERKit"]),
    ],
    dependencies: [
       // .package(url: "https://github.com/DarrenHurst/Community", branch: "main")
        //.package(url: "https://github.com/heap/heap-ios-sdk.git", .upToNextMajor(from: "9.0.0")),
        // Dependencies declare other packages that this package depends on.
        //  .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RENDERKit",
            dependencies: [//"Community"
            ] ,
            resources: [.process("Core/Resources")]),
        .testTarget(
            name: "RENDERKitTests",
            dependencies: ["RENDERKit"]),
    ]
)

 
 