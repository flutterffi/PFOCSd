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
