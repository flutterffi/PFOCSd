# Round 3: Combined Filtering Notes

This round adds `tag + state` combined filtering across all four architecture targets.

Targets:

- `P02StudyPlannerMVC`
- `P03StudyPlannerMVVM`
- `P04StudyPlannerMVP`
- `P05StudyPlannerVIPER`

## What Changed Everywhere

1. added a combined filtering path for `tag + state`
2. added one matching filter example and one empty-result example
3. added empty-state messaging so no-result behavior is visible

## Where Empty-State Handling Lives

### MVC

- empty-state handling stays inside controller-driven rendering
- the control flow is direct, but controller branching grows fastest

### MVVM

- filtering lives in the planner view model
- empty-state wording is shaped by the view model before the console view renders it

### MVP

- filtering and empty-state branching live in the presenter
- the view protocol stays thin and only displays either lines or a message

### VIPER

- filtering lives in the interactor
- empty-state wording and titles are routed through the router and presenter

## Best Way To Use This Round

1. run all four targets once
2. compare the matching `architecture + blocked` filter in each implementation
3. compare the empty `memory + blocked` filter in each implementation
4. record which architecture made the empty-state path feel clearest in `COMPARISON_WORKBOOK.md`
