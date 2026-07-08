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
                            priority:5
                    estimatedMinutes:35];
        [controller markTaskDoneAtIndex:0];
        [controller markTaskBlockedAtIndex:2];
        [controller renderTasks:[controller tasksFilteredByTag:@"architecture"] title:@"Filtered By Tag"];
        [controller renderTasks:controller.tasks title:@"Blocked State Added"];
        [controller renderTasks:[controller tasksSortedByPriorityFromTasks:controller.tasks] title:@"Priority Sorted"];
        [controller renderTasks:[controller tasksFilteredByTag:@"architecture" state:@(PFMVCStudyTaskStateBlocked)]
                          title:@"Combined Filter: architecture + blocked"];
        [controller renderTasks:[controller tasksFilteredByTag:@"memory" state:@(PFMVCStudyTaskStateBlocked)]
                          title:@"Combined Filter: memory + blocked"];
        [controller editTaskAtIndex:1 estimatedMinutes:45];
        [controller renderTasks:controller.tasks title:@"Edited Task Flow"];

        NSError *error = nil;
        NSString *path = [controller saveCurrentTasks:&error];
        NSLog(@"saved path -> %@", path);
        if (path != nil) {
            [controller reloadTasksFromPath:path error:&error];
        }
        [controller.store simulateNextSaveFailure];
        NSString *failedPath = [controller saveCurrentTasks:&error];
        NSLog(@"[MVC] Save Failure Drill");
        NSLog(@"%@", failedPath != nil ? @"unexpected save success" : error.localizedDescription);
        [controller renderTasks:controller.tasks title:@"Reloaded Tasks"];

        // Practice idea: compare how much persistence detail leaks out once MVC handles both edit orchestration and save-failure branching at the entry point.
    }
    return 0;
}
