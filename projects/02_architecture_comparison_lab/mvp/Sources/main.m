#import <Foundation/Foundation.h>
#import "PFMVPStudyPlannerPresenter.h"

int main(void) {
    @autoreleasepool {
        PFMVPConsoleView *view = [[PFMVPConsoleView alloc] init];
        PFMVPStudyPlannerPresenter *presenter = [[PFMVPStudyPlannerPresenter alloc] initWithView:view
                                                                                           store:[[PFMVPStudyTaskStore alloc] init]];

        [presenter bootstrap];
        [presenter showTasksFilteredByTag:nil title:@"Initial Tasks"];

        [presenter addTaskWithTitle:@"Compare MVC, MVVM, and MVP"
                              notes:@"watch presenter-owned formatting"
                               tags:@[@"architecture", @"comparison"]
                           priority:5
                   estimatedMinutes:35];
        [presenter markTaskDoneAtIndex:0];
        [presenter markTaskBlockedAtIndex:2];
        [presenter showTasksFilteredByTag:@"architecture" title:@"Filtered By Tag"];
        [presenter showTasksFilteredByTag:nil title:@"Blocked State Added"];
        [presenter showPrioritySortedTasksWithTitle:@"Priority Sorted"];
        [presenter showTasksFilteredByTag:@"architecture"
                                    state:@(PFMVPStudyTaskStateBlocked)
                                    title:@"Combined Filter: architecture + blocked"];
        [presenter showTasksFilteredByTag:@"memory"
                                    state:@(PFMVPStudyTaskStateBlocked)
                                    title:@"Combined Filter: memory + blocked"];
        [presenter editTaskAtIndex:1 estimatedMinutes:45];
        [presenter showTasksFilteredByTag:nil title:@"Edited Task Flow"];
        [presenter saveAndReload];
        [presenter simulateNextSaveFailure];
        [presenter saveAndReload];
        [presenter showTasksFilteredByTag:nil title:@"Reloaded Tasks"];

        // Practice idea: compare how much easier edit orchestration and save-failure narration feel once the presenter owns the branch.
    }
    return 0;
}
