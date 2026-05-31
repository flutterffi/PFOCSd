# Round 1: Blocked State Notes

This round is now implemented across all four architecture targets.

Targets:

- `P02StudyPlannerMVC`
- `P03StudyPlannerMVVM`
- `P04StudyPlannerMVP`
- `P05StudyPlannerVIPER`

## What Changed Everywhere

1. added a `blocked` enum case to the task entity
2. added `blocked` label support for persistence and rendering
3. changed one sample task so the new state appears immediately
4. added one explicit "mark blocked" action in the main training flow

## Where The Change Pressure Landed

### MVC

- state logic spread through the task model, store, controller, and `main.m`
- the controller absorbed the new interaction directly

### MVVM

- state logic spread through the task model, store, planner view model, task view model, and `main.m`
- display shaping stayed cleaner because labels already flowed through view models

### MVP

- state logic spread through the task model, store, presenter, and `main.m`
- interaction branching still stayed readable because the presenter already owned rendering decisions

### VIPER

- state logic spread through the entity, store, interactor, presenter, and `main.m`
- the extra action stayed structured, but the file count penalty was the highest

## Best Way To Use This Round

1. run all four targets once
2. trace the `blocked` change path in each implementation
3. add state-based filtering next
4. record which architecture felt most natural in `COMPARISON_WORKBOOK.md`
