# MVC

This version keeps responsibility close to the controller.

Use it to observe:

- how quickly one controller grows
- how much formatting and workflow logic stays inside that controller
- how direct the data flow feels in classic Cocoa style

## Target

- `P02StudyPlannerMVC`

## Edit First

- `Sources/PFMVCStudyPlannerController.m`
- `Sources/PFMVCStudyTask.m`
- `Sources/main.m`

## Best Drills Here

1. add `blocked` state and notice how much lands in the controller
2. add priority sorting and watch formatting logic stay close to workflow code
3. add an empty-state message and decide whether the controller or `main.m` should own it
