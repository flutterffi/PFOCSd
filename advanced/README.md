# Advanced

Use this folder when you want deeper Objective-C practice organized in a way that is closer to Apple's framework-level thinking.

This stage is now grouped by official-style capability tracks instead of one flat list.

## Official-Style Tracks

1. `01_runtime_and_memory/`
2. `02_cocoa_data_flow/`
3. `03_design_patterns/`
4. `04_concurrency/`

## What To Do Here

1. run one example
2. explain the behavior in your own words
3. modify one design choice
4. compare the output or side effects

## Best Starting Order

1. `01_runtime_and_memory/01_runtime_and_message_dispatch.m`
2. `01_runtime_and_memory/02_memory_management_and_blocks.m`
3. `01_runtime_and_memory/03_method_swizzling_and_forwarding.m`
4. `02_cocoa_data_flow/01_kvc_kvo_and_model_mapping.m`
5. `03_design_patterns/01_protocols_categories_and_service_design.m`
6. `04_concurrency/01_gcd_operations_and_thread_safety.m`
7. `04_concurrency/02_operation_cancellation_and_backpressure.m`

## Why This Layout Matches Better

- `runtime_and_memory`: selectors, ARC, object lifetime, dynamic dispatch, and runtime interception
- `cocoa_data_flow`: KVC, KVO, and model observation patterns
- `design_patterns`: protocols, categories, and service boundaries
- `concurrency`: GCD, operations, cancellation-aware orchestration, producer backpressure, and thread-safe state
