#import "PFVIPERStudyPlannerRouter.h"
#import "PFVIPERStudyTask.h"

@implementation PFVIPERStudyPlannerRouter

- (NSString *)titleForInitialList {
    return @"Initial Tasks";
}

- (NSString *)titleForFilteredListWithTag:(NSString *)tag {
    return [self titleForFilteredListWithTag:tag state:nil];
}

- (NSString *)titleForFilteredListWithTag:(NSString *)tag state:(NSNumber *)state {
    NSMutableArray<NSString *> *parts = [NSMutableArray array];
    if (tag.length == 0) {
        [parts addObject:@"All Tasks"];
    } else {
        [parts addObject:[NSString stringWithFormat:@"Tag: %@", tag]];
    }
    if (state != nil) {
        [parts addObject:[NSString stringWithFormat:@"State: %@",
                          PFVIPERStudyTaskStateLabel((PFVIPERStudyTaskState)state.integerValue)]];
    }
    if (parts.count == 1 && [parts.firstObject isEqualToString:@"All Tasks"]) {
        return @"All Tasks";
    }
    return [NSString stringWithFormat:@"Filtered By %@", [parts componentsJoinedByString:@" | "]];
}

- (NSString *)emptyMessageForTag:(NSString *)tag state:(NSNumber *)state {
    NSMutableArray<NSString *> *parts = [NSMutableArray array];
    if (tag.length > 0) {
        [parts addObject:[NSString stringWithFormat:@"tag=%@", tag]];
    }
    if (state != nil) {
        [parts addObject:[NSString stringWithFormat:@"state=%@",
                          PFVIPERStudyTaskStateLabel((PFVIPERStudyTaskState)state.integerValue)]];
    }
    if (parts.count == 0) {
        return @"no tasks matched this filter";
    }
    return [NSString stringWithFormat:@"no tasks matched %@",
            [parts componentsJoinedByString:@", "]];
}

- (NSString *)messageForSavedPath:(NSString *)path {
    if (path.length == 0) {
        return @"save failed";
    }
    return [NSString stringWithFormat:@"saved path -> %@", path];
}

- (NSString *)messageForReloadResult:(BOOL)success {
    return success ? @"reload succeeded" : @"reload failed";
}

@end
