# PFOCSd

PFOCSd is an English-first Objective-C practice repository focused on advanced training.

The goal is simple:

- keep every lesson runnable and compact
- move from syntax familiarity into runtime-level understanding
- practice design tradeoffs that still matter in modern Apple-platform codebases
- connect Objective-C language features to small real tasks instead of isolated trivia

## Start Here

If you want the repository organized by training purpose, use this order:

1. [Xcode Practice](./docs/XCODE_PRACTICE.md)
2. [Practice Map](./docs/PRACTICE_MAP.md)
3. [Official Path](./docs/OFFICIAL_PATH.md)
4. [Practice Path](./docs/PRACTICE_PATH.md)
5. [Study Paths](./docs/STUDY_PATHS.md)
6. [Challenges](./docs/CHALLENGES.md)
7. [30 Day Plan](./docs/learning_paths/30_day_plan.md)

## Direct Practice

If your goal is direct hands-on training in Xcode, open `Package.swift`.

This repository now includes multi-target Objective-C practice targets with `.h` and `.m` files:

- `F01ClassesAndProperties`
- `F02CategoriesAndProtocols`
- `F03FoundationObjects`
- `I01ModelMappingValidation`
- `I02FilePersistence`
- `I03OperationPipeline`
- `I04TestingMindset`
- `A01RuntimeDispatch`
- `A02MemoryAndBlocks`
- `A03KVCAndKVO`
- `A04DesignPatterns`
- `A05Concurrency`
- `P01TaskBoardCLI`
- `P02StudyPlannerMVC`
- `P03StudyPlannerMVVM`
- `P04StudyPlannerMVP`
- `P05StudyPlannerVIPER`

For architecture comparison training, also use:

- `projects/02_architecture_comparison_lab/feature_brief.md`
- `projects/02_architecture_comparison_lab/CHALLENGES.md`
- `projects/02_architecture_comparison_lab/COMPARISON_WORKBOOK.md`
- `projects/02_architecture_comparison_lab/ROUND_1_BLOCKED_STATE.md`
- `projects/02_architecture_comparison_lab/ROUND_2_PRIORITY_SUPPORT.md`

## Folder Guide

- `foundations/`: small syntax drills for daily warm-up practice
- `intermediate/`: slightly more realistic code organization drills
- `advanced/`: deeper runtime, memory, KVC/KVO, and concurrency practice
- `projects/`: hands-on project work and practical feature building
- `docs/`: study routes, challenge lists, and training plans
- `Sources/`: direct Xcode practice targets for progressive training

Open these local guides when entering a folder:

- [foundations/README.md](./foundations/README.md)
- [intermediate/README.md](./intermediate/README.md)
- [advanced/README.md](./advanced/README.md)
- [projects/README.md](./projects/README.md)
- [docs/README.md](./docs/README.md)

## Learning Path

### 1. Foundations

Each file in `foundations/` is a standalone Objective-C language lesson.

Suggested order:

1. `01_objective_c_language/01_classes_properties_and_initializers.m`
2. `02_language_features/01_categories_and_lightweight_generics.m`
3. `02_language_features/02_protocols_and_delegation_shape.m`
4. `02_language_features/03_error_patterns_and_nullability_style.m`
5. `02_language_features/04_blocks_and_collection_transformations.m`
6. `03_foundation_objects/01_nsstring_nsarray_nsdictionary.m`

Topics covered:

- Foundation collections and object messaging
- classes, properties, and designated initializers
- categories and lightweight generic annotations
- protocols and loosely coupled collaboration
- NSError-style API design
- blocks and collection-focused data shaping

### 2. Intermediate

The `intermediate/` folder moves from syntax drills into code organization and behavior.

Suggested order:

1. `01_foundation_data_flow/01_model_mapping_and_validation.m`
2. `01_foundation_data_flow/02_file_persistence_and_serialization.m`
3. `02_workflows_and_scheduling/01_nsoperation_queue_pipeline.m`
4. `03_validation_and_verification/01_testing_mindset_with_assertions.m`

Topics covered:

- model parsing and validation rules
- `NSOperationQueue` dependencies
- JSON/file persistence with Foundation
- assertion-driven training and regression checks

### 3. Advanced Lessons

The `advanced/` folder is now grouped by official-style tracks instead of one flat list.

Suggested order:

1. `01_runtime_and_memory/01_runtime_and_message_dispatch.m`
2. `01_runtime_and_memory/02_memory_management_and_blocks.m`
3. `02_cocoa_data_flow/01_kvc_kvo_and_model_mapping.m`
4. `03_design_patterns/01_protocols_categories_and_service_design.m`
5. `04_concurrency/01_gcd_operations_and_thread_safety.m`

Topics covered:

- selectors, `objc_msgSend`, and runtime-style dispatch thinking
- ARC behavior, copy semantics, retain cycles, and blocks
- KVC, KVO, dynamic lookup, and safe model transformation
- protocols, categories, lightweight generics, and dependency boundaries
- GCD, `NSOperationQueue`, barriers, and thread-safe state management

### 4. Project Practice

The `projects/` folder turns those concepts into a small command-line feature.

Current project:

1. `01_task_board_cli`

This mini project practices:

- model design with Objective-C objects
- protocol-driven formatting
- categorized behavior on Foundation types
- lightweight state transitions
- grouping and rendering task summaries
- splitting a CLI into multiple collaborating `.h` and `.m` files

## Repository Layout

```text
PFOCSd/
  foundations/                # Objective-C language and Foundation basics
  intermediate/               # Foundation workflows and verification drills
  advanced/                   # focused Objective-C advanced drills
  projects/                   # small runnable practice project
  docs/                       # study routes, challenge lists, and plans
  Sources/                    # multi-target Objective-C practice entry points
  Package.swift               # open this in Xcode for direct training
```

## Commands You Can Use Later

From the repository root, you can now use:

```bash
make list
make run FILE=foundations/03_foundation_objects/01_nsstring_nsarray_nsdictionary.m
make run FILE=advanced/04_concurrency/01_gcd_operations_and_thread_safety.m
make run FILE=projects/01_task_board_cli/main.m
make run FILE=projects/01_task_board_cli/main.m ARGS="--state done"
make run FILE=projects/01_task_board_cli/main.m ARGS="--load projects/01_task_board_cli/data/sample_tasks.json"
make run FILE=projects/01_task_board_cli/main.m ARGS="--load projects/01_task_board_cli/data/sample_tasks.json --state doing"
make run FILE=projects/01_task_board_cli/main.m ARGS="--format compact"
make run FILE=projects/01_task_board_cli/main.m ARGS="--load projects/01_task_board_cli/data/sample_tasks.json --format compact"
make run FILE=projects/01_task_board_cli/main.m ARGS="--save /tmp/pfocsd-tasks.json"
make check
make clean
```

You can also still compile files manually:

On macOS with Xcode Command Line Tools installed, run files like this:

```bash
clang -fobjc-arc -framework Foundation advanced/01_runtime_and_memory/01_runtime_and_message_dispatch.m -o /tmp/pfocsd-01
/tmp/pfocsd-01

clang -fobjc-arc -framework Foundation foundations/02_language_features/01_categories_and_lightweight_generics.m -o /tmp/pfocsd-foundations-03
/tmp/pfocsd-foundations-03

clang -fobjc-arc -framework Foundation intermediate/01_foundation_data_flow/02_file_persistence_and_serialization.m -o /tmp/pfocsd-intermediate-03
/tmp/pfocsd-intermediate-03

clang -fobjc-arc -framework Foundation advanced/04_concurrency/01_gcd_operations_and_thread_safety.m -o /tmp/pfocsd-05
/tmp/pfocsd-05

clang -fobjc-arc -framework Foundation projects/01_task_board_cli/*.m -o /tmp/pfocsd-task-board
/tmp/pfocsd-task-board
/tmp/pfocsd-task-board --load projects/01_task_board_cli/data/sample_tasks.json
/tmp/pfocsd-task-board --state done
/tmp/pfocsd-task-board --format compact
/tmp/pfocsd-task-board --save /tmp/pfocsd-tasks.json
```

The task board CLI also supports:

- `--load <file>` to read tasks from a JSON file
- `--save <file>` to write the current task list to a JSON file
- `--format verbose|compact` to switch renderers
- built-in sample tasks when `--load` is not provided

## How To Practice

Use the repository in loops:

1. Read one lesson.
2. Predict the output or memory behavior.
3. Change one rule.
4. Run it again.
5. Add one more variation beside it.

Good modifications to try:

- rewrite one lesson as two collaborating classes
- add one more runtime-inspected selector
- introduce a retain cycle, then remove it
- expand one KVC mapping rule
- replace one concrete dependency with a protocol-backed collaborator
- add one more state transition to the task board
