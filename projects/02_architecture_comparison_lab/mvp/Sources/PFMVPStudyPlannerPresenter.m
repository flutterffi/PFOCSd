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
        estimatedMinutes:(NSInteger)estimatedMinutes {
    NSMutableArray<PFMVPStudyTask *> *nextTasks = [self.tasks mutableCopy];
    [nextTasks addObject:[[PFMVPStudyTask alloc] initWithTitle:title
                                                         notes:notes
                                                          tags:tags
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
    NSArray<PFMVPStudyTask *> *sourceTasks = self.tasks;
    if (tag.length > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(PFMVPStudyTask *task, NSDictionary<NSString *, id> *bindings) {
            return [task.tags containsObject:tag];
        }];
        sourceTasks = [sourceTasks filteredArrayUsingPredicate:predicate];
    }

    NSMutableArray<NSString *> *lines = [NSMutableArray arrayWithCapacity:sourceTasks.count];
    NSUInteger index = 0;
    for (PFMVPStudyTask *task in sourceTasks) {
        [lines addObject:[NSString stringWithFormat:@"%lu. %@ | %@ | %ld min | %@",
                          (unsigned long)(index + 1),
                          task.title,
                          PFMVPStudyTaskStateLabel(task.state),
                          (long)task.estimatedMinutes,
                          [task.tags componentsJoinedByString:@", "]]];
        index += 1;
    }

    [self.view displayLines:lines title:title];
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

@end
