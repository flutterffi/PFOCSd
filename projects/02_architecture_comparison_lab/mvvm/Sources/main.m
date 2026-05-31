#import <Foundation/Foundation.h>
#import "PFMVVMConsoleView.h"
#import "PFMVVMStudyPlannerViewModel.h"

int main(void) {
    @autoreleasepool {
        PFMVVMStudyPlannerViewModel *viewModel = [[PFMVVMStudyPlannerViewModel alloc] initWithStore:[[PFMVVMStudyTaskStore alloc] init]];
        PFMVVMConsoleView *view = [[PFMVVMConsoleView alloc] init];

        [viewModel bootstrap];
        [view renderViewModels:[viewModel taskViewModelsFilteredByTag:nil] title:@"Initial Tasks"];

        [viewModel addTaskWithTitle:@"Compare MVC and MVVM"
                              notes:@"watch state shaping move into the view model"
                               tags:@[@"architecture", @"comparison"]
                           priority:5
                   estimatedMinutes:35];
        [viewModel markTaskDoneAtIndex:0];
        [viewModel markTaskBlockedAtIndex:2];
        [view renderViewModels:[viewModel taskViewModelsFilteredByTag:@"architecture"] title:@"Filtered By Tag"];
        [view renderViewModels:[viewModel taskViewModelsFilteredByTag:nil] title:@"Blocked State Added"];
        [view renderViewModels:[viewModel prioritySortedTaskViewModels] title:@"Priority Sorted"];
        [view renderViewModels:[viewModel taskViewModelsFilteredByTag:@"architecture"
                                                                state:@(PFMVVMStudyTaskStateBlocked)]
                         title:@"Combined Filter: architecture + blocked"
                  emptyMessage:[viewModel emptyMessageForTag:@"architecture"
                                                      state:@(PFMVVMStudyTaskStateBlocked)]];
        [view renderViewModels:[viewModel taskViewModelsFilteredByTag:@"memory"
                                                                state:@(PFMVVMStudyTaskStateBlocked)]
                         title:@"Combined Filter: memory + blocked"
                  emptyMessage:[viewModel emptyMessageForTag:@"memory"
                                                      state:@(PFMVVMStudyTaskStateBlocked)]];

        NSError *error = nil;
        NSString *path = [viewModel saveCurrentTasks:&error];
        NSLog(@"%@", [viewModel saveFeedbackMessageForPath:path error:error]);
        if (path != nil) {
            [viewModel reloadTasksFromPath:path error:&error];
        }
        [viewModel simulateNextSaveFailure];
        NSString *failedPath = [viewModel saveCurrentTasks:&error];
        NSLog(@"[MVVM] Save Failure Drill");
        NSLog(@"%@", [viewModel saveFeedbackMessageForPath:failedPath error:error]);
        [view renderViewModels:[viewModel taskViewModelsFilteredByTag:nil] title:@"Reloaded Tasks"];

        // Practice idea: compare how much cleaner save-failure wording feels once the view model owns the feedback text.
    }
    return 0;
}
