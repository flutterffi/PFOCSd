# Changelog

## 0.1.0 - 2026-05-28

- Created the initial `PFOCSd` Objective-C practice repository structure.
- Added foundation, intermediate, and advanced training lessons.
- Added a multi-file `01_task_board_cli` project for practical Objective-C design practice.
- Added guided study paths, a 30-day plan, and challenge prompts.

## 0.2.0 - 2026-05-28

- Added `--state` filtering to the task board CLI so one board section can be rendered on demand.
- Added state parsing and validation with readable error output for unsupported filter values.
- Expanded the README examples to show filtered project execution.

## 0.3.0 - 2026-05-28

- Added JSON-based task loading and saving for `01_task_board_cli` with `--load` and `--save`.
- Added a dedicated `PFTaskFileStore` for task mapping, validation, and disk persistence.
- Added a sample task dataset and expanded the README with persistence examples.

## 0.4.0 - 2026-05-28

- Added a `PFTaskRendering` protocol to decouple board rendering from the CLI entry point.
- Kept the existing verbose renderer and added a new `PFCompactRenderer`.
- Added `--format verbose|compact` support and documented the new output modes.

## 0.5.0 - 2026-05-31

- Reorganized the advanced track into official-style subfolders for runtime and memory, Cocoa data flow, design patterns, and concurrency.
- Added `docs/OFFICIAL_PATH.md` and `docs/PRACTICE_PATH.md` to separate system learning from repetition-focused drilling.
- Added folder-level READMEs so each training area is easier to enter and use for hands-on practice.

## 0.6.0 - 2026-05-31

- Reorganized the foundations track into official-style language, language feature, and Foundation object folders.
- Reorganized the intermediate track into Foundation data flow, workflow scheduling, and validation-focused folders.
- Updated the root guide, study paths, challenge references, and build defaults to match the new foundations and intermediate layout.

## 0.7.0 - 2026-05-31

- Added a multi-target Objective-C Swift Package so the repository can be opened directly in Xcode through `Package.swift`.
- Added hands-on practice targets for classes and properties, categories and protocols, Foundation objects, and the task board CLI.
- Added `docs/XCODE_PRACTICE.md` so the new direct-practice workflow is easy to follow.

## 0.8.0 - 2026-05-31

- Added intermediate Objective-C practice targets for model mapping, file persistence, operation pipelines, and assertion-driven verification.
- Expanded the package so the repository now supports direct Xcode practice across foundations, intermediate lessons, and the task board project.
- Added visible extension points inside the new intermediate targets so they can be used as progressive practice exercises instead of read-only examples.

## 0.9.0 - 2026-05-31

- Added advanced Objective-C practice targets for runtime dispatch, memory and blocks, KVC and KVO, design patterns, and concurrency.
- Expanded the direct Xcode practice flow so the repository now covers foundations, intermediate lessons, advanced lessons, and the task board project through one package entry point.
- Added visible extension prompts inside the new advanced targets so they can be used for progressive hands-on training instead of passive review.

## 0.10.0 - 2026-05-31

- Added the first architecture comparison lab targets with a runnable MVC implementation and a runnable MVVM implementation of the same study planner feature set.
- Expanded the package and Xcode practice guide so architecture-level training now sits beside the language, intermediate, advanced, and project targets.
- Added shared comparison docs so later MVP and VIPER implementations can be added against the same feature brief.

## 0.11.0 - 2026-05-31

- Added a runnable MVP implementation to the architecture comparison lab using a presenter and view protocol boundary.
- Expanded the package so MVC, MVVM, and MVP can now be compared directly against the same study planner feature brief.
- Updated the architecture lab progress docs so the next step is a focused VIPER implementation instead of a broad redesign.
