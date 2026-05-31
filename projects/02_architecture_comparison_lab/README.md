# 02 Architecture Comparison Lab

This project family is for architecture-level Objective-C training.

The goal is to build the same app multiple times and compare the tradeoffs directly.

## Planned Architectures

1. MVC
2. MVVM
3. MVP
4. VIPER

Current progress:

- MVC: scaffolded as a runnable package target
- MVVM: scaffolded as a runnable package target
- MVP: scaffolded as a runnable package target
- VIPER: scaffolded as a runnable package target

## Core Rule

Every architecture must implement the same feature set.

Do not compare different apps.
Compare different responsibility splits.

## Proposed Shared App

`Study Planner App`

Suggested feature set:

1. show a list of study tasks
2. create a task
3. edit a task
4. mark a task done
5. filter tasks
6. persist local data

## Proposed Layout

```text
02_architecture_comparison_lab/
  README.md
  feature_brief.md
  shared_fixtures/
  mvc/
  mvvm/
  mvp/
  viper/
```

## Best Build Order

1. build MVC first
2. rebuild the same feature with MVVM
3. rebuild the same feature with MVP
4. rebuild the same feature with VIPER

## Current Runnable Targets

- `P02StudyPlannerMVC`
- `P03StudyPlannerMVVM`
- `P04StudyPlannerMVP`
- `P05StudyPlannerVIPER`

## Practice Assets

- `feature_brief.md`
- `CHALLENGES.md`
- `COMPARISON_WORKBOOK.md`
- `ROUND_1_BLOCKED_STATE.md`
- `ROUND_2_PRIORITY_SUPPORT.md`

## What To Write Down After Each Version

1. what got simpler
2. what got more verbose
3. what became easier to test
4. where navigation logic ended up
