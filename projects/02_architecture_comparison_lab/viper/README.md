# VIPER Study Planner

This variant rebuilds the same study planner feature set with a VIPER-style split.

## Components

- `Entity`: `PFVIPERStudyTask`
- `Interactor`: `PFVIPERStudyPlannerInteractor`
- `Presenter`: `PFVIPERStudyPlannerPresenter`
- `View`: `PFVIPERConsoleView`
- `Router`: `PFVIPERStudyPlannerRouter`

## What To Notice

1. the presenter formats view models instead of touching storage details
2. the interactor owns task mutations and persistence flow
3. the router is small here, but still owns screen-level narration
4. the view only renders strings and action summaries

## Suggested Practice

1. add one route for an empty-state walkthrough
2. move save success and failure text fully into presenter-owned view models
3. add one more task state and keep the routing rules readable
