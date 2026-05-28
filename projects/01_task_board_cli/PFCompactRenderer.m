#import "PFCompactRenderer.h"

@implementation PFCompactRenderer

- (void)renderBoard:(PFTaskBoard *)board onlyState:(NSNumber *)stateFilter {
    NSDictionary<NSNumber *, NSArray<PFTask *> *> *groups = [board groupedTasksByState];
    NSArray<NSNumber *> *order = stateFilter != nil
        ? @[stateFilter]
        : @[@(PFTaskStateTodo), @(PFTaskStateDoing), @(PFTaskStateDone)];

    for (NSNumber *stateNumber in order) {
        PFTaskState state = stateNumber.integerValue;
        NSArray<PFTask *> *tasks = groups[stateNumber] ?: @[];
        NSMutableArray<NSString *> *titles = [NSMutableArray arrayWithCapacity:tasks.count];

        for (PFTask *task in tasks) {
            [titles addObject:task.title];
        }

        NSString *summary = titles.count > 0 ? [titles componentsJoinedByString:@" | "] : @"(empty)";
        NSLog(@"%@ (%lu): %@", PFTaskStateLabel(state), (unsigned long)tasks.count, summary);
    }
}

@end
