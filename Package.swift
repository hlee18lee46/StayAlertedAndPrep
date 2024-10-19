// swift-tools-version: 5.3
import PackageDescription

let package = Package(
    name: "StayAlertedAndPrep",
    platforms: [
        .iOS(.v10)  // Specify the minimum deployment target
    ],
    products: [
        .library(
            name: "StayAlertedAndPrep",
            targets: ["StayAlertedAndPrep"]),
    ],
    dependencies: [
        // Correctly formatted dependency
        .package(url: "https://github.com/googlemaps/google-maps-ios-utils.git", from: "3.10.0")
    ],
    targets: [
        .target(
            name: "StayAlertedAndPrep",
            dependencies: [
                // Link your target with the dependency libraries
                "google-maps-ios-utils"
            ]
        ),
        .testTarget(
            name: "StayAlertedAndPrepTests",
            dependencies: ["StayAlertedAndPrep"]),
    ]
)
