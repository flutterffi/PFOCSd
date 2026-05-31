# Challenges

Use these after you finish the example files once. The goal is to force one meaningful code change per stage.

## Foundations

1. Add a new property to `PFStudyCard` and include it in the summary output.
2. Turn one free function into an Objective-C instance method.
3. Extend the category in `02_language_features/01_categories_and_lightweight_generics.m` with one more formatting helper.
4. Change the delegation example so the delegate receives both a title and a timestamp.
5. Make `parsePositiveScore` reject non-numeric strings more explicitly.
6. In the blocks lesson, sort the filtered tasks before printing them.

## Intermediate

1. In `01_foundation_data_flow/01_model_mapping_and_validation.m`, support an optional `notes` field.
2. In `02_workflows_and_scheduling/01_nsoperation_queue_pipeline.m`, add a fourth operation that depends on `render`.
3. In `01_foundation_data_flow/02_file_persistence_and_serialization.m`, deserialize into model objects instead of raw dictionaries.
4. In `03_validation_and_verification/01_testing_mindset_with_assertions.m`, add two more assertions, including one edge case.

## Advanced

1. Add one more dynamic selector to `01_runtime_and_memory/01_runtime_and_message_dispatch.m`.
2. Create an intentional retain-cycle example in `01_runtime_and_memory/02_memory_management_and_blocks.m`, then fix it.
3. In the KVC/KVO lesson, track a second observable property.
4. Replace the scorer in `03_design_patterns/01_protocols_categories_and_service_design.m` with a second strategy implementation.
5. In the concurrency lesson, add a reset method to the counter and verify it under parallel access.

## Project

1. Add a new `blocked` state to the task board.
2. Sort tasks alphabetically inside each board section.
3. Add persistence using the JSON approach from `intermediate/01_foundation_data_flow/02_file_persistence_and_serialization.m`.
4. Extract task rendering behind a protocol and add a compact renderer.
5. Add a command-line argument that prints only one requested state.
