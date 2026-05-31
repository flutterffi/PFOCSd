# MVVM

This version moves display shaping and screen state into a view model.

Use it to observe:

- how the view controller gets thinner
- how display strings and filter state move into the view model
- how much explicit update wiring Objective-C still needs

## Target

- `P03StudyPlannerMVVM`

## Edit First

- `Sources/PFMVVMStudyPlannerViewModel.m`
- `Sources/PFMVVMStudyTaskViewModel.m`
- `Sources/main.m`

## Best Drills Here

1. add `blocked` state and keep derived labels inside the view-model layer
2. add priority sorting and compare model sorting with rendered ordering
3. add an empty-state message and see whether it belongs in the view model or the console view
