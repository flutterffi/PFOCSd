# Architecture Training

Use this guide when you want to practice app architecture at the project level instead of only learning language features.

## Training Goal

The point is not to memorize architecture names.

The point is to build the same feature set multiple times and compare:

- how responsibilities move
- where state lives
- how testability changes
- how navigation is handled
- how much boilerplate each approach creates

## Recommended Training Shape

Do not teach MVC, MVVM, MVP, and VIPER as isolated theory chapters.

Teach them as one shared comparison lab.

Recommended project family:

- `projects/02_architecture_comparison_lab/`

Inside that lab, keep one shared feature brief and multiple implementations:

- `mvc/`
- `mvvm/`
- `mvp/`
- `viper/`

Core practice files:

- `projects/02_architecture_comparison_lab/feature_brief.md`
- `projects/02_architecture_comparison_lab/CHALLENGES.md`
- `projects/02_architecture_comparison_lab/COMPARISON_WORKBOOK.md`
- `projects/02_architecture_comparison_lab/ROUND_1_BLOCKED_STATE.md`

## Shared Feature Brief

All architectures should implement the same small app so the comparison stays fair.

Recommended feature:

`Study Planner App`

Why this feature works well:

- has list screens
- has detail screens
- has filtering and sorting
- has form input
- has persistence
- has simple navigation
- has enough state to expose architecture tradeoffs

## Same Requirements Across All Architectures

Each implementation should support:

1. list study tasks
2. add a new task
3. edit a task
4. mark a task done
5. filter by state or tag
6. save and reload local data

Keep the feature set identical.
Never let one architecture get extra convenience features, or the comparison becomes noisy.

## What Each Architecture Should Emphasize

### MVC

Focus:

- controller-heavy flow
- model updates directly affecting the view controller
- the classic Objective-C Cocoa baseline

What to observe:

- how quickly controllers grow
- where formatting logic starts leaking

### MVVM

Focus:

- view model state shaping
- formatting and derived state outside the view controller
- clearer mapping between model and displayed text

What to observe:

- how much cleaner the view controller becomes
- how much binding glue you still need in Objective-C

### MVP

Focus:

- explicit presenter coordination
- view protocol boundaries
- testability through presenter-driven behavior

What to observe:

- how easy interaction tests become
- how much protocol work is added

### VIPER

Focus:

- strict responsibility splits
- router navigation
- entity / interactor / presenter boundaries

What to observe:

- how scalable the module shape feels
- how much setup cost and boilerplate it introduces

## Recommended Training Order

1. MVC
2. MVVM
3. MVP
4. VIPER

Why this order:

- MVC gives the baseline Cocoa shape
- MVVM shows the first serious extraction of presentation state
- MVP makes the collaboration boundary more explicit
- VIPER is easiest to understand after the others

## How To Structure The Comparison Lab

Recommended layout:

```text
projects/02_architecture_comparison_lab/
  README.md
  feature_brief.md
  shared_fixtures/
  mvc/
  mvvm/
  mvp/
  viper/
```

Inside each architecture folder:

```text
<architecture>/
  README.md
  Sources/
  Tests/
```

## Best Practice Method

Do not build four unrelated apps.

Build one baseline feature set and port it architecture by architecture.

Suggested loop:

1. implement MVC first
2. write down pain points
3. rebuild the same feature in MVVM
4. compare file responsibilities
5. rebuild the same feature in MVP
6. compare testability
7. rebuild the same feature in VIPER
8. compare scaling cost

## What To Compare Explicitly

After each implementation, write down:

1. file count
2. view controller size
3. testability
4. navigation complexity
5. state ownership clarity
6. boilerplate cost

## How To Turn This Into Real Practice

Use one change request at a time across all four implementations.

Suggested order:

1. run the current target
2. pick one drill from `CHALLENGES.md`
3. implement it in MVC
4. implement the same drill in MVVM
5. implement the same drill in MVP
6. implement the same drill in VIPER
7. fill in `COMPARISON_WORKBOOK.md`

This prevents “architecture tourism” where you only read file names without feeling the tradeoffs in code.

## Best Repository Strategy For This Project

For this repository, the strongest design is:

- keep current language and lesson targets
- add one dedicated architecture comparison lab project
- add one target per architecture implementation later
- keep the same fixtures and task data across all architecture variants

This gives you:

- language training
- project training
- architecture comparison
- repeatable hands-on practice
