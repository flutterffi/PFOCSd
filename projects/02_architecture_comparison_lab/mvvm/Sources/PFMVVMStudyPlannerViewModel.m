#import "PFMVVMStudyPlannerViewModel.h"

@implementation PFMVVMStudyPlannerViewModel

- (instancetype)initWithStore:(PFMVVMStudyTaskStore *)store {
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
    NSMutableArray<PFMVVMStudyTask *> *nextTasks = [self.tasks mutableCopy];
    [nextTasks addObject:[[PFMVVMStudyTask alloc] initWithTitle:title
                                                          notes:notes
                                                           tags:tags
                                                       priority:priority
                                               estimatedMinutes:estimatedMinutes
                                                          state:PFMVVMStudyTaskStateTodo]];
    self.tasks = [nextTasks copy];
}

- (void)markTaskDoneAtIndex:(NSUInteger)index {
    if (index >= self.tasks.count) {
        return;
    }
    PFMVVMStudyTask *task = self.tasks[index];
    task.state = PFMVVMStudyTaskStateDone;
}

- (void)markTaskBlockedAtIndex:(NSUInteger)index {
    if (index >= self.tasks.count) {
        return;
    }
    PFMVVMStudyTask *task = self.tasks[index];
    task.state = PFMVVMStudyTaskStateBlocked;
}

- (NSArray<PFMVVMStudyTaskViewModel *> *)taskViewModelsFilteredByTag:(NSString *)tag {
    NSArray<PFMVVMStudyTask *> *sourceTasks = self.tasks;
    if (tag.length > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(PFMVVMStudyTask *task, NSDictionary<NSString *, id> *bindings) {
            return [task.tags containsObject:tag];
        }];
        sourceTasks = [sourceTasks filteredArrayUsingPredicate:predicate];
    }

    return [self viewModelsFromTasks:sourceTasks];
}

- (NSArray<PFMVVMStudyTaskViewModel *> *)prioritySortedTaskViewModels {
    NSArray<PFMVVMStudyTask *> *sortedTasks = [self.tasks sortedArrayUsingComparator:^NSComparisonResult(PFMVVMStudyTask *lhs, PFMVVMStudyTask *rhs) {
        if (lhs.priority == rhs.priority) {
            return [lhs.title compare:rhs.title];
        }
        return lhs.priority > rhs.priority ? NSOrderedAscending : NSOrderedDescending;
    }];
    return [self viewModelsFromTasks:sortedTasks];
}

- (NSArray<PFMVVMStudyTaskViewModel *> *)viewModelsFromTasks:(NSArray<PFMVVMStudyTask *> *)tasks {
    NSMutableArray<PFMVVMStudyTaskViewModel *> *viewModels = [NSMutableArray arrayWithCapacity:tasks.count];
    for (PFMVVMStudyTask *task in tasks) {
        [viewModels addObject:[[PFMVVMStudyTaskViewModel alloc] initWithTask:task]];
    }
    return [viewModels copy];
}

- (nullable NSString *)saveCurrentTasks:(NSError **)error {
    return [self.store saveTasks:self.tasks error:error];
}

- (BOOL)reloadTasksFromPath:(NSString *)path error:(NSError **)error {
    NSArray<PFMVVMStudyTask *> *loadedTasks = [self.store loadTasksFromPath:path error:error];
    if (loadedTasks == nil) {
        return NO;
    }
    self.tasks = loadedTasks;
    return YES;
}

@end
