#import "PFVIPERStudyPlannerInteractor.h"

@interface PFVIPERStudyPlannerInteractor ()
@property (nonatomic, strong, readwrite) PFVIPERStudyTaskStore *store;
@property (nonatomic, copy, readwrite) NSArray<PFVIPERStudyTask *> *tasks;
@end

@implementation PFVIPERStudyPlannerInteractor

- (instancetype)initWithStore:(PFVIPERStudyTaskStore *)store {
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
    NSMutableArray<PFVIPERStudyTask *> *nextTasks = [self.tasks mutableCopy];
    [nextTasks addObject:[[PFVIPERStudyTask alloc] initWithTitle:title
                                                           notes:notes
                                                            tags:tags
                                                estimatedMinutes:estimatedMinutes
                                                           state:PFVIPERStudyTaskStateTodo]];
    self.tasks = [nextTasks copy];
}

- (void)markTaskDoneAtIndex:(NSUInteger)index {
    if (index >= self.tasks.count) {
        return;
    }
    self.tasks[index].state = PFVIPERStudyTaskStateDone;
}

- (NSArray<PFVIPERStudyTask *> *)tasksFilteredByTag:(NSString *)tag {
    if (tag.length == 0) {
        return self.tasks;
    }

    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(PFVIPERStudyTask *task, NSDictionary<NSString *, id> *bindings) {
        return [task.tags containsObject:tag];
    }];
    return [self.tasks filteredArrayUsingPredicate:predicate];
}

- (nullable NSString *)saveTasksWithError:(NSError **)error {
    return [self.store saveTasks:self.tasks error:error];
}

- (BOOL)reloadTasksFromPath:(NSString *)path error:(NSError **)error {
    NSArray<PFVIPERStudyTask *> *loadedTasks = [self.store loadTasksFromPath:path error:error];
    if (loadedTasks == nil) {
        return NO;
    }
    self.tasks = loadedTasks;
    return YES;
}

@end
