# 01 Task Board CLI

This project is the main hands-on Objective-C practice area in `PFOCSd`.

## What This Project Trains

- object modeling with `PFTask` and `PFTaskBoard`
- file persistence with `PFTaskFileStore`
- protocol-based rendering with `PFTaskRendering`
- CLI argument handling in `main.m`

## Useful Commands

```bash
make run FILE=projects/01_task_board_cli/main.m
make run FILE=projects/01_task_board_cli/main.m ARGS="--format compact"
make run FILE=projects/01_task_board_cli/main.m ARGS="--load projects/01_task_board_cli/data/sample_tasks.json"
make run FILE=projects/01_task_board_cli/main.m ARGS="--load projects/01_task_board_cli/data/sample_tasks.json --state doing"
make run FILE=projects/01_task_board_cli/main.m ARGS="--save /private/tmp/pfocsd-tasks.json"
```

## Folder Map

- `data/`: repeatable sample JSON input
- `PFTask.*`: task model and state conversion
- `PFTaskBoard.*`: grouping and board logic
- `PFTaskFileStore.*`: JSON mapping and persistence
- `PFConsoleRenderer.*`: verbose output
- `PFCompactRenderer.*`: compact output
- `PFTaskRendering.h`: rendering boundary

## Good Practice Tasks

1. add a new state
2. add tag filtering
3. add sorting controls
4. add a new renderer
