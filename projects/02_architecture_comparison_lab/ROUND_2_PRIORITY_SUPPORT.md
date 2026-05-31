# Round 2: Priority Support Notes

This round adds a real `priority` field across all four architecture targets.

Targets:

- `P02StudyPlannerMVC`
- `P03StudyPlannerMVVM`
- `P04StudyPlannerMVP`
- `P05StudyPlannerVIPER`

## What Changed Everywhere

1. added `priority` to the task entity
2. persisted `priority` through JSON save and reload
3. added one high-priority sample task in the main flow
4. rendered a `Priority Sorted` screen in every architecture

## Where Sorting Lives

### MVC

- sorting lives on the controller
- rendering and workflow still stay very close together

### MVVM

- sorting lives in the planner view model
- display text keeps the priority label inside task view models

### MVP

- sorting lives in the presenter
- the presenter now owns both ordering and line formatting decisions

### VIPER

- sorting lives in the interactor
- the presenter still decides when to render the sorted list

## Best Way To Use This Round

1. run all four targets once
2. compare where sorting logic was added first
3. compare whether priority formatting felt closer to model, presenter, or view-model code
4. record the result in `COMPARISON_WORKBOOK.md`
