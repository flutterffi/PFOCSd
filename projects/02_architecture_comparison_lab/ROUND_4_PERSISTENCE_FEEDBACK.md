# Round 4: Persistence Feedback Notes

This round adds a simulated save-failure path across all four architecture targets.

Targets:

- `P02StudyPlannerMVC`
- `P03StudyPlannerMVVM`
- `P04StudyPlannerMVP`
- `P05StudyPlannerVIPER`

## What Changed Everywhere

1. added a one-shot simulated save failure in each task store
2. kept the normal save-and-reload flow working first
3. triggered one explicit save-failure drill after the successful save

## Where Failure Messaging Lives

### MVC

- the store creates the error
- `main.m` decides how to print the failure
- persistence details leak furthest outward

### MVVM

- the store creates the error
- the view model shapes the save-feedback message
- the console view stays simple, but `main.m` still coordinates the sequence

### MVP

- the store creates the error
- the presenter owns the failure branch and message choice
- the view only renders the final failure text

### VIPER

- the store creates the error
- the interactor exposes the failure
- the router formats the message and the presenter decides when to show it

## Best Way To Use This Round

1. run all four targets once
2. compare the first successful save path
3. compare the second simulated failure path
4. record which architecture kept storage details most contained in `COMPARISON_WORKBOOK.md`
