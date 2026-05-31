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
        estimatedMinutes:(NSInteger)estimatedMinutes {
    NSMutableArray<PFMVCStudyTask *> *nextTasks = [self.tasks mutableCopy];
    [nextTasks addObject:[[PFMVCStudyTask alloc] initWithTitle:title
                                                         notes:notes
                                                          tags:tags
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
    if (tag.length == 0) {
        return self.tasks;
    }

    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(PFMVCStudyTask *task, NSDictionary<NSString *, id> *bindings) {
        return [task.tags containsObject:tag];
    }];
    return [self.tasks filteredArrayUsingPredicate:predicate];
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
    NSUInteger index = 0;
    for (PFMVCStudyTask *task in tasks) {
        NSLog(@"%lu. %@ | %@ | %ld min | %@",
              (unsigned long)(index + 1),
              task.title,
              PFMVCStudyTaskStateLabel(task.state),
              (long)task.estimatedMinutes,
              [task.tags componentsJoinedByString:@", "]);
        index += 1;
    }
}

@end
