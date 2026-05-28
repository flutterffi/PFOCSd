#import "PFConsoleRenderer.h"

@implementation PFConsoleRenderer

- (void)renderBoard:(PFTaskBoard *)board {
    [self renderBoard:board onlyState:nil];
}

- (void)renderBoard:(PFTaskBoard *)board onlyState:(NSNumber *)stateFilter {
    NSDictionary<NSNumber *, NSArray<PFTask *> *> *groups = [board groupedTasksByState];
    NSArray<NSNumber *> *order = stateFilter != nil
        ? @[stateFilter]
        : @[@(PFTaskStateTodo), @(PFTaskStateDoing), @(PFTaskStateDone)];

    for (NSNumber *stateNumber in order) {
        PFTaskState state = stateNumber.integerValue;
        NSLog(@"[%@]", PFTaskStateLabel(state));

        for (PFTask *task in groups[stateNumber] ?: @[]) {
            NSLog(@"- %@ | %@", task.title, [task.tags componentsJoinedByString:@", "]);
        }
    }
}

@end
