#import "PFMVCStudyPlannerController.h"

@implementation PFMVCStudyPlannerController

- (instancetype)initWithStore:(PFMVCStudyTaskStore *)store {
    self = [super init];
    if (self) {
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
    NSMutableArray<PFMVCStudyTask *> *nextTasks = [self.tasks mutableCopy];
    [nextTasks addObject:[[PFMVCStudyTask alloc] initWithTitle:title
                                                         notes:notes
                                                          tags:tags
                                                      priority:priority
                                              estimatedMinutes:estimatedMinutes
                                                         state:PFMVCStudyTaskStateTodo]];
    self.tasks = [nextTasks copy];
}

- (void)markTaskDoneAtIndex:(NSUInteger)index {
    if (index >= self.tasks.count) {
        return;
    }

    PFMVCStudyTask *task = self.tasks[index];
    task.state = PFMVCStudyTaskStateDone;
}

- (void)markTaskBlockedAtIndex:(NSUInteger)index {
    if (index >= self.tasks.count) {
        return;
    }

    PFMVCStudyTask *task = self.tasks[index];
    task.state = PFMVCStudyTaskStateBlocked;
}

- (NSArray<PFMVCStudyTask *> *)tasksFilteredByTag:(NSString *)tag {
    return [self tasksFilteredByTag:tag state:nil];
}

- (NSArray<PFMVCStudyTask *> *)tasksFilteredByTag:(NSString *)tag
                                            state:(NSNumber *)state {
    NSArray<PFMVCStudyTask *> *sourceTasks = self.tasks;
    if (tag.length == 0) {
        sourceTasks = self.tasks;
    } else {
        NSPredicate *tagPredicate = [NSPredicate predicateWithBlock:^BOOL(PFMVCStudyTask *task, NSDictionary<NSString *, id> *bindings) {
            return [task.tags containsObject:tag];
        }];
        sourceTasks = [sourceTasks filteredArrayUsingPredicate:tagPredicate];
    }

    if (state != nil) {
        PFMVCStudyTaskState expectedState = (PFMVCStudyTaskState)state.integerValue;
        NSPredicate *statePredicate = [NSPredicate predicateWithBlock:^BOOL(PFMVCStudyTask *task, NSDictionary<NSString *, id> *bindings) {
            return task.state == expectedState;
        }];
        sourceTasks = [sourceTasks filteredArrayUsingPredicate:statePredicate];
    }
    return sourceTasks;
}

- (NSArray<PFMVCStudyTask *> *)tasksSortedByPriorityFromTasks:(NSArray<PFMVCStudyTask *> *)tasks {
    return [tasks sortedArrayUsingComparator:^NSComparisonResult(PFMVCStudyTask *lhs, PFMVCStudyTask *rhs) {
        if (lhs.priority == rhs.priority) {
            return [lhs.title compare:rhs.title];
        }
        return lhs.priority > rhs.priority ? NSOrderedAscending : NSOrderedDescending;
    }];
}

- (nullable NSString *)saveCurrentTasks:(NSError **)error {
    return [self.store saveTasks:self.tasks error:error];
}

- (BOOL)reloadTasksFromPath:(NSString *)path error:(NSError **)error {
    NSArray<PFMVCStudyTask *> *loadedTasks = [self.store loadTasksFromPath:path error:error];
    if (loadedTasks == nil) {
        return NO;
    }
    self.tasks = loadedTasks;
    return YES;
}

- (void)renderTasks:(NSArray<PFMVCStudyTask *> *)tasks title:(NSString *)title {
    NSLog(@"[MVC] %@", title);
    if (tasks.count == 0) {
        NSLog(@"no tasks matched this filter");
        return;
    }
    NSUInteger index = 0;
    for (PFMVCStudyTask *task in tasks) {
        NSLog(@"%lu. %@ | %@ | %ld min | %@",
              (unsigned long)(index + 1),
              task.title,
              PFMVCStudyTaskStateLabel(task.state),
              (long)task.estimatedMinutes,
              [NSString stringWithFormat:@"P%ld | %@", (long)task.priority, [task.tags componentsJoinedByString:@", "]]);
        index += 1;
    }
}

@end
