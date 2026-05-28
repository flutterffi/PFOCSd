#import "PFTaskBoard.h"

@interface PFTaskBoard ()
@property (nonatomic, copy, readwrite) NSArray<PFTask *> *tasks;
@end

@implementation PFTaskBoard

- (instancetype)initWithTasks:(NSArray<PFTask *> *)tasks {
    self = [super init];
    if (self) {
        _tasks = [tasks copy];
    }
    return self;
}

- (NSDictionary<NSNumber *, NSArray<PFTask *> *> *)groupedTasksByState {
    NSMutableDictionary<NSNumber *, NSMutableArray<PFTask *> *> *groups = [NSMutableDictionary dictionary];

    for (PFTask *task in self.tasks) {
        NSNumber *key = @(task.state);
        if (groups[key] == nil) {
            groups[key] = [NSMutableArray array];
        }
        [groups[key] addObject:task];
    }

    NSMutableDictionary<NSNumber *, NSArray<PFTask *> *> *snapshot = [NSMutableDictionary dictionary];
    for (NSNumber *key in groups) {
        NSArray<PFTask *> *sorted = [groups[key] sortedArrayUsingComparator:^NSComparisonResult(PFTask *left, PFTask *right) {
            return [left.title localizedCaseInsensitiveCompare:right.title];
        }];
        snapshot[key] = sorted;
    }

    return [snapshot copy];
}

- (NSArray<PFTask *> *)tasksForState:(PFTaskState)state {
    NSDictionary<NSNumber *, NSArray<PFTask *> *> *groups = [self groupedTasksByState];
    return groups[@(state)] ?: @[];
}

@end
