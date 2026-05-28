# PFOCSd

PFOCSd is an English-first Objective-C practice repository focused on advanced training.

The goal is simple:

- keep every lesson runnable and compact
- move from syntax familiarity into runtime-level understanding
- practice design tradeoffs that still matter in modern Apple-platform codebases
- connect Objective-C language features to small real tasks instead of isolated trivia

## Study Plans

If you want a guided route instead of picking files manually, start here:

- [STUDY_PATHS.md](./STUDY_PATHS.md)
- [30 Day Plan](./learning_paths/30_day_plan.md)
- [CHALLENGES.md](./CHALLENGES.md)

## Learning Path

### 1. Foundations

Each file in `foundations/` is a standalone Objective-C language lesson.

Suggested order:

1. `01_nsstring_nsarray_nsdictionary.m`
2. `02_classes_properties_and_initializers.m`
3. `03_categories_and_lightweight_generics.m`
4. `04_protocols_and_delegation_shape.m`
5. `05_error_patterns_and_nullability_style.m`
6. `06_blocks_and_collection_transformations.m`

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

1. `01_model_mapping_and_validation.m`
2. `02_nsoperation_queue_pipeline.m`
3. `03_file_persistence_and_serialization.m`
4. `04_testing_mindset_with_assertions.m`

Topics covered:

- model parsing and validation rules
- `NSOperationQueue` dependencies
- JSON/file persistence with Foundation
- assertion-driven training and regression checks

### 3. Advanced Lessons

Each file in `advanced/` is a self-contained Foundation-based advanced training lesson.

Suggested order:

1. `01_runtime_and_message_dispatch.m`
2. `02_memory_management_and_blocks.m`
3. `03_kvc_kvo_and_model_mapping.m`
4. `04_protocols_categories_and_service_design.m`
5. `05_gcd_operations_and_thread_safety.m`

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
  intermediate/              # design and organization drills
  advanced/                   # focused Objective-C advanced drills
  projects/                   # small runnable practice project
  learning_paths/             # guided study plans
  STUDY_PATHS.md              # route chooser
  CHALLENGES.md               # change-driven training tasks
```

## Commands You Can Use Later

From the repository root, you can now use:

```bash
make list
make run FILE=foundations/01_nsstring_nsarray_nsdictionary.m
make run FILE=advanced/05_gcd_operations_and_thread_safety.m
make run FILE=projects/01_task_board_cli/main.m
make run FILE=projects/01_task_board_cli/main.m ARGS="--state done"
make check
make clean
```

You can also still compile files manually:

On macOS with Xcode Command Line Tools installed, run files like this:

```bash
clang -fobjc-arc -framework Foundation advanced/01_runtime_and_message_dispatch.m -o /tmp/pfocsd-01
/tmp/pfocsd-01

clang -fobjc-arc -framework Foundation foundations/03_categories_and_lightweight_generics.m -o /tmp/pfocsd-foundations-03
/tmp/pfocsd-foundations-03

clang -fobjc-arc -framework Foundation intermediate/03_file_persistence_and_serialization.m -o /tmp/pfocsd-intermediate-03
/tmp/pfocsd-intermediate-03

clang -fobjc-arc -framework Foundation advanced/05_gcd_operations_and_thread_safety.m -o /tmp/pfocsd-05
/tmp/pfocsd-05

clang -fobjc-arc -framework Foundation projects/01_task_board_cli/*.m -o /tmp/pfocsd-task-board
/tmp/pfocsd-task-board
/tmp/pfocsd-task-board --state done
```

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
