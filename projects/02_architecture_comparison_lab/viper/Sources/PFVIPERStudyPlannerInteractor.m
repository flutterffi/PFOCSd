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
                priority:(NSInteger)priority
        estimatedMinutes:(NSInteger)estimatedMinutes {
    NSMutableArray<PFVIPERStudyTask *> *nextTasks = [self.tasks mutableCopy];
    [nextTasks addObject:[[PFVIPERStudyTask alloc] initWithTitle:title
                                                           notes:notes
                                                            tags:tags
                                                        priority:priority
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

- (void)markTaskBlockedAtIndex:(NSUInteger)index {
    if (index >= self.tasks.count) {
        return;
    }
    self.tasks[index].state = PFVIPERStudyTaskStateBlocked;
}

- (NSArray<PFVIPERStudyTask *> *)tasksFilteredByTag:(NSString *)tag {
    return [self tasksFilteredByTag:tag state:nil];
}

- (NSArray<PFVIPERStudyTask *> *)tasksFilteredByTag:(NSString *)tag
                                              state:(NSNumber *)state {
    NSArray<PFVIPERStudyTask *> *sourceTasks = self.tasks;
    if (tag.length == 0) {
        sourceTasks = self.tasks;
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(PFVIPERStudyTask *task, NSDictionary<NSString *, id> *bindings) {
            return [task.tags containsObject:tag];
        }];
        sourceTasks = [sourceTasks filteredArrayUsingPredicate:predicate];
    }

    if (state != nil) {
        PFVIPERStudyTaskState expectedState = (PFVIPERStudyTaskState)state.integerValue;
        NSPredicate *statePredicate = [NSPredicate predicateWithBlock:^BOOL(PFVIPERStudyTask *task, NSDictionary<NSString *, id> *bindings) {
            return task.state == expectedState;
        }];
        sourceTasks = [sourceTasks filteredArrayUsingPredicate:statePredicate];
    }
    return sourceTasks;
}

- (NSArray<PFVIPERStudyTask *> *)prioritySortedTasks {
    return [self.tasks sortedArrayUsingComparator:^NSComparisonResult(PFVIPERStudyTask *lhs, PFVIPERStudyTask *rhs) {
        if (lhs.priority == rhs.priority) {
            return [lhs.title compare:rhs.title];
        }
        return lhs.priority > rhs.priority ? NSOrderedAscending : NSOrderedDescending;
    }];
}

- (void)simulateNextSaveFailure {
    [self.store simulateNextSaveFailure];
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
