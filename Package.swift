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
        .executable(name: "A01RuntimeDispatch", targets: ["A01RuntimeDispatch"]),
        .executable(name: "A02MemoryAndBlocks", targets: ["A02MemoryAndBlocks"]),
        .executable(name: "A03KVCAndKVO", targets: ["A03KVCAndKVO"]),
        .executable(name: "A04DesignPatterns", targets: ["A04DesignPatterns"]),
        .executable(name: "A05Concurrency", targets: ["A05Concurrency"]),
        .executable(name: "P02StudyPlannerMVC", targets: ["P02StudyPlannerMVC"]),
        .executable(name: "P03StudyPlannerMVVM", targets: ["P03StudyPlannerMVVM"]),
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
            name: "A01RuntimeDispatch",
            path: "Sources/A01RuntimeDispatch",
            linkerSettings: [
                .linkedFramework("Foundation"),
            ]
        ),
        .executableTarget(
            name: "A02MemoryAndBlocks",
            path: "Sources/A02MemoryAndBlocks",
            linkerSettings: [
                .linkedFramework("Foundation"),
            ]
        ),
        .executableTarget(
            name: "A03KVCAndKVO",
            path: "Sources/A03KVCAndKVO",
            linkerSettings: [
                .linkedFramework("Foundation"),
            ]
        ),
        .executableTarget(
            name: "A04DesignPatterns",
            path: "Sources/A04DesignPatterns",
            linkerSettings: [
                .linkedFramework("Foundation"),
            ]
        ),
        .executableTarget(
            name: "A05Concurrency",
            path: "Sources/A05Concurrency",
            linkerSettings: [
                .linkedFramework("Foundation"),
            ]
        ),
        .executableTarget(
            name: "P02StudyPlannerMVC",
            path: "projects/02_architecture_comparison_lab/mvc/Sources",
            linkerSettings: [
                .linkedFramework("Foundation"),
            ]
        ),
        .executableTarget(
            name: "P03StudyPlannerMVVM",
            path: "projects/02_architecture_comparison_lab/mvvm/Sources",
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
