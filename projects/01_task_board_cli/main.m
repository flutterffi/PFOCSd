#import <Foundation/Foundation.h>
#import "PFConsoleRenderer.h"

static NSNumber *PFParseStateArgument(NSString *value) {
    NSDictionary<NSString *, NSNumber *> *stateMap = @{
        @"todo": @(PFTaskStateTodo),
        @"doing": @(PFTaskStateDoing),
        @"done": @(PFTaskStateDone)
    };

    return stateMap[value.lowercaseString];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray<PFTask *> *tasks = @[
            [[PFTask alloc] initWithTitle:@"practice selector dispatch"
                                     tags:@[@"runtime", @"objc"]
                                    state:PFTaskStateTodo],
            [[PFTask alloc] initWithTitle:@"review retain cycle example"
                                     tags:@[@"memory", @"blocks"]
                                    state:PFTaskStateDoing],
            [[PFTask alloc] initWithTitle:@"build KVC mapping drill"
                                     tags:@[@"kvc", @"models"]
                                    state:PFTaskStateDone]
        ];

        PFTaskBoard *board = [[PFTaskBoard alloc] initWithTasks:tasks];
        PFConsoleRenderer *renderer = [[PFConsoleRenderer alloc] init];
        NSNumber *stateFilter = nil;

        for (int i = 1; i < argc; i++) {
            NSString *argument = [NSString stringWithUTF8String:argv[i]];
            if ([argument isEqualToString:@"--state"]) {
                if (i + 1 >= argc) {
                    NSLog(@"error: missing value for --state");
                    return 1;
                }

                NSString *value = [NSString stringWithUTF8String:argv[i + 1]];
                stateFilter = PFParseStateArgument(value);
                if (stateFilter == nil) {
                    NSLog(@"error: unsupported state '%@'. Use todo, doing, or done.", value);
                    return 1;
                }
                i += 1;
            }
        }

        [renderer renderBoard:board onlyState:stateFilter];
    }
    return 0;
}
