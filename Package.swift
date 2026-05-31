// swift-tools-version: 6.3
import PackageDescription

let package = Package(
    name: "PFOCSd",
    platforms: [
        .macOS(.v14),
    ],
    products: [
        .executable(name: "F01ClassesAndProperties", targets: ["F01ClassesAndProperties"]),
        .executable(name: "F02CategoriesAndProtocols", targets: ["F02CategoriesAndProtocols"]),
        .executable(name: "F03FoundationObjects", targets: ["F03FoundationObjects"]),
        .executable(name: "I01ModelMappingValidation", targets: ["I01ModelMappingValidation"]),
        .executable(name: "I02FilePersistence", targets: ["I02FilePersistence"]),
        .executable(name: "I03OperationPipeline", targets: ["I03OperationPipeline"]),
        .executable(name: "I04TestingMindset", targets: ["I04TestingMindset"]),
        .executable(name: "P01TaskBoardCLI", targets: ["P01TaskBoardCLI"]),
    ],
    targets: [
        .executableTarget(
            name: "F01ClassesAndProperties",
            path: "Sources/F01ClassesAndProperties",
            linkerSettings: [
                .linkedFramework("Foundation"),
            ]
        ),
        .executableTarget(
            name: "F02CategoriesAndProtocols",
            path: "Sources/F02CategoriesAndProtocols",
            linkerSettings: [
                .linkedFramework("Foundation"),
            ]
        ),
        .executableTarget(
            name: "F03FoundationObjects",
            path: "Sources/F03FoundationObjects",
            linkerSettings: [
                .linkedFramework("Foundation"),
            ]
        ),
        .executableTarget(
            name: "I01ModelMappingValidation",
            path: "Sources/I01ModelMappingValidation",
            linkerSettings: [
                .linkedFramework("Foundation"),
            ]
        ),
        .executableTarget(
            name: "I02FilePersistence",
            path: "Sources/I02FilePersistence",
            linkerSettings: [
                .linkedFramework("Foundation"),
            ]
        ),
        .executableTarget(
            name: "I03OperationPipeline",
            path: "Sources/I03OperationPipeline",
            linkerSettings: [
                .linkedFramework("Foundation"),
            ]
        ),
        .executableTarget(
            name: "I04TestingMindset",
            path: "Sources/I04TestingMindset",
            linkerSettings: [
                .linkedFramework("Foundation"),
            ]
        ),
        .executableTarget(
            name: "P01TaskBoardCLI",
            path: "projects/01_task_board_cli",
            linkerSettings: [
                .linkedFramework("Foundation"),
            ]
        ),
    ]
)
