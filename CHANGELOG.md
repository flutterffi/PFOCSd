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

## 0.12.0 - 2026-05-31

- Added a runnable VIPER implementation to the architecture comparison lab with separate entity, interactor, presenter, router, and view layers.
- Expanded the package and Xcode practice guide so MVC, MVVM, MVP, and VIPER can now be compared directly against the same study planner feature brief.
- Added a dedicated VIPER practice guide so the training focus stays on responsibility boundaries instead of file-count trivia.

## 0.13.0 - 2026-05-31

- Added shared architecture challenge prompts so MVC, MVVM, MVP, and VIPER can be trained with the same change requests instead of disconnected demos.
- Added a comparison workbook to record tradeoffs around state ownership, boilerplate, testability, and navigation after each drill.
- Expanded each architecture guide with target-specific edit entry points so hands-on practice starts from the right files instead of guesswork.

## 0.14.0 - 2026-05-31

- Implemented the first shared architecture drill by adding a runnable `blocked` task state across MVC, MVVM, MVP, and VIPER.
- Added explicit blocked-state actions in each architecture target so the same interaction can be traced through different responsibility splits.
- Added a focused round-one guide so the first architecture comparison exercise is concrete, repeatable, and easy to review.

## 0.15.0 - 2026-05-31

- Implemented the second shared architecture drill by adding persistent task priority support across MVC, MVVM, MVP, and VIPER.
- Added priority-sorted output flows in every architecture target so the same sorting requirement can be traced through different responsibility splits.
- Added a focused round-two guide so priority modeling, formatting, and ordering tradeoffs can be compared directly.

## 0.16.0 - 2026-05-31

- Implemented the third shared architecture drill by adding combined `tag + state` filtering across MVC, MVVM, MVP, and VIPER.
- Added matching and empty-result filter flows in every architecture target so state queries and empty-state handling can be compared directly.
- Added a focused round-three guide so filtering ownership, presenter branching, and empty-state responsibilities are easy to review.

## 0.17.0 - 2026-05-31

- Implemented the fourth shared architecture drill by adding a simulated save-failure path across MVC, MVVM, MVP, and VIPER.
- Added architecture-specific save-feedback flows so persistence errors can be compared through controller, view-model, presenter, and router boundaries.
- Added a focused round-four guide so failure ownership and storage-detail leakage are easy to review.

## 1.0.0 - 2026-05-31

- Declared the first stable training release of `PFOCSd` after completing the lesson tracks, direct Xcode targets, practical CLI project, and architecture comparison lab.
- Added a final review guide so the full learning loop can be repeated from fundamentals through architecture drills without more repository restructuring.
- Locked in the main training path so future additions can remain incremental instead of redefining the core structure.

## 1.1.0 - 2026-07-08

- Implemented the fifth shared architecture drill by adding a task edit flow across MVC, MVVM, MVP, and VIPER.
- Added edited-task rerender flows in every architecture target so workflow orchestration can be compared directly after filtering, sorting, and persistence drills.
- Added a focused round-five guide so edit ownership and post-action render flow are easy to review.

## 1.2.0 - 2026-07-08

- Added a new advanced runtime training target, `A06RuntimeInterception`, focused on method swizzling, fast forwarding, and full invocation forwarding.
- Added a matching standalone advanced lesson so the same runtime interception ideas can be studied both as a compact file and as a multi-file Xcode target.
- Expanded the advanced training guides so the runtime track now goes beyond dispatch basics into interception and forwarding mechanics.

## 1.3.0 - 2026-07-08

- Added a new advanced concurrency training target, `A07OperationCancellation`, focused on operation cancellation, dependency-aware sequencing, and producer-side backpressure.
- Added a matching standalone advanced lesson so cancellation-aware orchestration can be studied both as a compact file and as a multi-file Xcode target.
- Expanded the advanced training guides so the concurrency track now goes beyond queue basics into cancellable workflow coordination.

## 1.4.0 - 2026-07-08

- Added a new advanced scheduling training target, `A08RunLoopCoordination`, focused on run loop workers, timer delivery, and thread-bound event coordination.
- Added a matching standalone advanced lesson so run loop and timer behavior can be studied both as a compact file and as a multi-file Xcode target.
- Expanded the advanced training guides so the concurrency track now includes Cocoa-style scheduling mechanics alongside GCD and operations.
