#import <Foundation/Foundation.h>
#import "PFMVCStudyPlannerController.h"

int main(void) {
    @autoreleasepool {
        PFMVCStudyPlannerController *controller = [[PFMVCStudyPlannerController alloc] initWithStore:[[PFMVCStudyTaskStore alloc] init]];
        [controller bootstrap];
        [controller renderTasks:controller.tasks title:@"Initial Tasks"];

        [controller addTaskWithTitle:@"Compare MVC and MVVM"
                               notes:@"watch controller growth"
                                tags:@[@"architecture", @"comparison"]
                    estimatedMinutes:35];
        [controller markTaskDoneAtIndex:0];
        [controller markTaskBlockedAtIndex:2];
        [controller renderTasks:[controller tasksFilteredByTag:@"architecture"] title:@"Filtered By Tag"];
        [controller renderTasks:controller.tasks title:@"Blocked State Added"];

        NSError *error = nil;
        NSString *path = [controller saveCurrentTasks:&error];
        NSLog(@"saved path -> %@", path);
        if (path != nil) {
            [controller reloadTasksFromPath:path error:&error];
        }
        [controller renderTasks:controller.tasks title:@"Reloaded Tasks"];

        // Practice idea: add state-based filtering and watch how much branching stays in the controller.
    }
    return 0;
}
