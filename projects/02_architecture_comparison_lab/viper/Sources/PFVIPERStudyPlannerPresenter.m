#import "PFVIPERStudyPlannerPresenter.h"

@implementation PFVIPERStudyPlannerPresenter

- (instancetype)initWithView:(id<PFVIPERStudyPlannerView>)view
                  interactor:(PFVIPERStudyPlannerInteractor *)interactor
                      router:(PFVIPERStudyPlannerRouter *)router {
    self = [super init];
    if (self) {
        _view = view;
        _interactor = interactor;
        _router = router;
    }
    return self;
}

- (void)bootstrap {
    [self.interactor bootstrap];
    [self renderTasks:[self.interactor tasksFilteredByTag:nil]
                title:[self.router titleForInitialList]];
}

- (void)addTaskWithTitle:(NSString *)title
                   notes:(NSString *)notes
                    tags:(NSArray<NSString *> *)tags
                priority:(NSInteger)priority
        estimatedMinutes:(NSInteger)estimatedMinutes {
    [self.interactor addTaskWithTitle:title
                                notes:notes
                                 tags:tags
                             priority:priority
                     estimatedMinutes:estimatedMinutes];
}

- (void)markTaskDoneAtIndex:(NSUInteger)index {
    [self.interactor markTaskDoneAtIndex:index];
}

- (void)markTaskBlockedAtIndex:(NSUInteger)index {
    [self.interactor markTaskBlockedAtIndex:index];
}

- (void)showTasksFilteredByTag:(NSString *)tag {
    [self showTasksFilteredByTag:tag state:nil];
}

- (void)showTasksFilteredByTag:(NSString *)tag
                         state:(NSNumber *)state {
    NSArray<PFVIPERStudyTask *> *tasks = [self.interactor tasksFilteredByTag:tag state:state];
    NSString *title = [self.router titleForFilteredListWithTag:tag ?: @"" state:state];
    if (tasks.count == 0) {
        [self.view displayMessage:[self.router emptyMessageForTag:tag state:state] title:title];
        return;
    }
    [self renderTasks:tasks title:title];
}

- (void)showPrioritySortedTasks {
    [self renderTasks:[self.interactor prioritySortedTasks]
                title:@"Priority Sorted"];
}

- (void)simulateNextSaveFailure {
    [self.interactor simulateNextSaveFailure];
}

- (void)saveAndReload {
    NSError *error = nil;
    NSString *path = [self.interactor saveTasksWithError:&error];
    [self.view displayActionMessage:[self.router messageForSavedPath:path error:error]];
    if (path == nil) {
        return;
    }

    BOOL success = [self.interactor reloadTasksFromPath:path error:&error];
    [self.view displayActionMessage:[self.router messageForReloadResult:success]];
}

- (void)renderTasks:(NSArray<PFVIPERStudyTask *> *)tasks title:(NSString *)title {
    NSMutableArray<NSString *> *lines = [NSMutableArray arrayWithCapacity:tasks.count];
    NSUInteger index = 0;
    for (PFVIPERStudyTask *task in tasks) {
        [lines addObject:[NSString stringWithFormat:@"%lu. %@ | %@ | %ld min | %@",
                          (unsigned long)(index + 1),
                          task.title,
                          PFVIPERStudyTaskStateLabel(task.state),
                          (long)task.estimatedMinutes,
                          [NSString stringWithFormat:@"P%ld | %@", (long)task.priority, [task.tags componentsJoinedByString:@", "]]]];
        index += 1;
    }
    [self.view displayLines:lines title:title];
}

@end
