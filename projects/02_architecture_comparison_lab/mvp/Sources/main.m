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
                   estimatedMinutes:35];
        [presenter markTaskDoneAtIndex:0];
        [presenter showTasksFilteredByTag:@"architecture" title:@"Filtered By Tag"];
        [presenter saveAndReload];
        [presenter showTasksFilteredByTag:nil title:@"Reloaded Tasks"];

        // Practice idea: add a view protocol method for errors and move all display decisions into the presenter.
    }
    return 0;
}
