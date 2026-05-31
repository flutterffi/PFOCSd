#import "PFMVPStudyPlannerPresenter.h"

@implementation PFMVPStudyPlannerPresenter

- (instancetype)initWithView:(id<PFMVPStudyPlannerView>)view
                       store:(PFMVPStudyTaskStore *)store {
    self = [super init];
    if (self) {
        _view = view;
        _store = store;
        _tasks = @[];
    }
    return self;
}

- (void)bootstrap {
    self.tasks = [self.store defaultTasks];
}

- (void)addTaskWithTitle:(NSString *)title
                   notes:(NSString *)notes
                    tags:(NSArray<NSString *> *)tags
                priority:(NSInteger)priority
        estimatedMinutes:(NSInteger)estimatedMinutes {
    NSMutableArray<PFMVPStudyTask *> *nextTasks = [self.tasks mutableCopy];
    [nextTasks addObject:[[PFMVPStudyTask alloc] initWithTitle:title
                                                         notes:notes
                                                          tags:tags
                                                      priority:priority
                                              estimatedMinutes:estimatedMinutes
                                                         state:PFMVPStudyTaskStateTodo]];
    self.tasks = [nextTasks copy];
}

- (void)markTaskDoneAtIndex:(NSUInteger)index {
    if (index >= self.tasks.count) {
        return;
    }
    PFMVPStudyTask *task = self.tasks[index];
    task.state = PFMVPStudyTaskStateDone;
}

- (void)markTaskBlockedAtIndex:(NSUInteger)index {
    if (index >= self.tasks.count) {
        return;
    }
    PFMVPStudyTask *task = self.tasks[index];
    task.state = PFMVPStudyTaskStateBlocked;
}

- (void)showTasksFilteredByTag:(NSString *)tag title:(NSString *)title {
    [self showTasksFilteredByTag:tag state:nil title:title];
}

- (void)showTasksFilteredByTag:(NSString *)tag
                         state:(NSNumber *)state
                         title:(NSString *)title {
    NSArray<PFMVPStudyTask *> *sourceTasks = self.tasks;
    if (tag.length > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(PFMVPStudyTask *task, NSDictionary<NSString *, id> *bindings) {
            return [task.tags containsObject:tag];
        }];
        sourceTasks = [sourceTasks filteredArrayUsingPredicate:predicate];
    }

    if (state != nil) {
        PFMVPStudyTaskState expectedState = (PFMVPStudyTaskState)state.integerValue;
        NSPredicate *statePredicate = [NSPredicate predicateWithBlock:^BOOL(PFMVPStudyTask *task, NSDictionary<NSString *, id> *bindings) {
            return task.state == expectedState;
        }];
        sourceTasks = [sourceTasks filteredArrayUsingPredicate:statePredicate];
    }

    if (sourceTasks.count == 0) {
        [self.view displayMessage:[self emptyMessageForTag:tag state:state] title:title];
        return;
    }

    [self showLinesForTasks:sourceTasks title:title];
}

- (void)showPrioritySortedTasksWithTitle:(NSString *)title {
    NSArray<PFMVPStudyTask *> *sortedTasks = [self.tasks sortedArrayUsingComparator:^NSComparisonResult(PFMVPStudyTask *lhs, PFMVPStudyTask *rhs) {
        if (lhs.priority == rhs.priority) {
            return [lhs.title compare:rhs.title];
        }
        return lhs.priority > rhs.priority ? NSOrderedAscending : NSOrderedDescending;
    }];
    [self showLinesForTasks:sortedTasks title:title];
}

- (void)saveAndReload {
    NSError *error = nil;
    NSString *path = [self.store saveTasks:self.tasks error:&error];
    [self.view displaySavedPath:path];
    if (path == nil) {
        return;
    }
    NSArray<PFMVPStudyTask *> *loadedTasks = [self.store loadTasksFromPath:path error:&error];
    if (loadedTasks != nil) {
        self.tasks = loadedTasks;
    }
}

- (void)showLinesForTasks:(NSArray<PFMVPStudyTask *> *)tasks title:(NSString *)title {
    NSMutableArray<NSString *> *lines = [NSMutableArray arrayWithCapacity:tasks.count];
    NSUInteger index = 0;
    for (PFMVPStudyTask *task in tasks) {
        [lines addObject:[NSString stringWithFormat:@"%lu. %@ | %@ | P%ld | %ld min | %@",
                          (unsigned long)(index + 1),
                          task.title,
                          PFMVPStudyTaskStateLabel(task.state),
                          (long)task.priority,
                          (long)task.estimatedMinutes,
                          [task.tags componentsJoinedByString:@", "]]];
        index += 1;
    }
    [self.view displayLines:lines title:title];
}

- (NSString *)emptyMessageForTag:(NSString *)tag state:(NSNumber *)state {
    NSMutableArray<NSString *> *parts = [NSMutableArray array];
    if (tag.length > 0) {
        [parts addObject:[NSString stringWithFormat:@"tag=%@", tag]];
    }
    if (state != nil) {
        [parts addObject:[NSString stringWithFormat:@"state=%@", PFMVPStudyTaskStateLabel((PFMVPStudyTaskState)state.integerValue)]];
    }
    if (parts.count == 0) {
        return @"no tasks matched this filter";
    }
    return [NSString stringWithFormat:@"no tasks matched %@",
            [parts componentsJoinedByString:@", "]];
}

@end
