# MVP

This version moves interaction flow and formatting into a presenter and keeps the view behind a protocol.

Use it to observe:

- how presenter-driven updates improve testability
- how explicit the view boundary becomes
- how much protocol and coordination code gets added

## Target

- `P04StudyPlannerMVP`

## Edit First

- `Sources/PFMVPStudyPlannerPresenter.m`
- `Sources/PFMVPStudyPlannerView.h`
- `Sources/main.m`

## Best Drills Here

1. add `blocked` state and keep presentation decisions in the presenter
2. add save-failure output and extend the view protocol instead of leaking UI text into storage
3. add combined filtering and compare how easy it is to test presenter-owned branching
