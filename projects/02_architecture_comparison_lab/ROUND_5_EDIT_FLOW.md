# Round 5: Edit Flow Notes

This round adds a simple task-edit flow across all four architecture targets.

Targets:

- `P02StudyPlannerMVC`
- `P03StudyPlannerMVVM`
- `P04StudyPlannerMVP`
- `P05StudyPlannerVIPER`

## What Changed Everywhere

1. added an edit action that updates one task's `estimatedMinutes`
2. re-rendered the full task list after the edit
3. kept the earlier filtering, sorting, and persistence flows intact

## Where Edit Orchestration Lives

### MVC

- the controller mutates the task directly
- the entry flow decides when to re-render

### MVVM

- the planner view model owns the edit
- the view stays passive and only renders updated view models

### MVP

- the presenter coordinates the edit and the next render
- the edit branch stays close to the presentation flow

### VIPER

- the interactor performs the mutation
- the presenter decides when the edited module should be shown again

## Best Way To Use This Round

1. run all four targets once
2. compare which file you would open first to add a second editable field
3. compare how obvious the post-edit render flow feels
4. record which architecture made workflow orchestration easiest to read in `COMPARISON_WORKBOOK.md`
