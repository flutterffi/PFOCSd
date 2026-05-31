# Architecture Challenges

Use the same drills across MVC, MVVM, MVP, and VIPER.

Do not change the task itself when you switch architectures.
Only change how the responsibilities are split.

## Round 1: State Expansion

1. add a `blocked` task state
2. render the new state in the list
3. keep the filtering flow readable

Questions:

- which file changed first?
- where did state-to-label logic belong?
- which architecture spread the change across the most files?

## Round 2: Priority Support

1. add `priority` to the task entity
2. show it in the list output
3. sort tasks by priority before rendering

Questions:

- where did formatting pressure appear?
- which architecture made sorting easiest to localize?
- which architecture made the entity stay cleanest?

## Round 3: Combined Filtering

1. support filtering by both tag and state
2. keep the command flow or demo flow readable
3. show an empty-state message when nothing matches

Questions:

- where did query logic live?
- where did empty-state text live?
- which architecture made screen-state changes easiest to express?

## Round 4: Persistence Feedback

1. simulate a save failure path
2. render a user-facing failure message
3. keep persistence details out of display code when possible

Questions:

- who creates the failure message?
- which layer knows too much about storage?
- which architecture is easiest to test here?

## Round 5: Edit Flow

1. add an edit action for notes or estimated minutes
2. re-render the changed task list
3. keep navigation or workflow responsibilities explicit

Questions:

- where does edit orchestration belong?
- which architecture made workflow branching easiest to read?
- where did you feel the most boilerplate pressure?
