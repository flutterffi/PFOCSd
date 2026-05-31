#import "PFVIPERStudyPlannerRouter.h"

@implementation PFVIPERStudyPlannerRouter

- (NSString *)titleForInitialList {
    return @"Initial Tasks";
}

- (NSString *)titleForFilteredListWithTag:(NSString *)tag {
    if (tag.length == 0) {
        return @"All Tasks";
    }
    return [NSString stringWithFormat:@"Filtered By Tag: %@", tag];
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
