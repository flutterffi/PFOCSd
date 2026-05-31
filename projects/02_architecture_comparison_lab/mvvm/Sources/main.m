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

        NSError *error = nil;
        NSString *path = [viewModel saveCurrentTasks:&error];
        NSLog(@"saved path -> %@", path);
        if (path != nil) {
            [viewModel reloadTasksFromPath:path error:&error];
        }
        [view renderViewModels:[viewModel taskViewModelsFilteredByTag:nil] title:@"Reloaded Tasks"];

        // Practice idea: combine blocked-only screen state with priority sorting and keep all label shaping in the view-model layer.
    }
    return 0;
}
