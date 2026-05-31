# Feature Brief

Build the same small app in multiple architectures.

## App Name

`Study Planner App`

## User Stories

1. As a learner, I can create a study task.
2. As a learner, I can edit a study task.
3. As a learner, I can mark a task as done.
4. As a learner, I can filter tasks by tag or state.
5. As a learner, I can relaunch the app and keep my saved tasks.

## Suggested Screens

1. task list
2. task detail
3. task edit or create form

## Required Shared Data Model

- `id`
- `title`
- `notes`
- `state`
- `tags`
- `estimatedMinutes`

## Comparison Rule

Each architecture must use the same:

- data model
- user stories
- persistence rules
- filter behavior

Only the architecture may change.
