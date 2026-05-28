#import <Foundation/Foundation.h>
#import "PFConsoleRenderer.h"
#import "PFTaskFileStore.h"

static NSArray<PFTask *> *PFSampleTasks(void) {
    return @[
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
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSNumber *stateFilter = nil;
        NSString *loadPath = nil;
        NSString *savePath = nil;

        for (int i = 1; i < argc; i++) {
            NSString *argument = [NSString stringWithUTF8String:argv[i]];
            if ([argument isEqualToString:@"--state"]) {
                if (i + 1 >= argc) {
                    NSLog(@"error: missing value for --state");
                    return 1;
                }

                NSString *value = [NSString stringWithUTF8String:argv[i + 1]];
                stateFilter = PFTaskStateNumberFromLabel(value);
                if (stateFilter == nil) {
                    NSLog(@"error: unsupported state '%@'. Use todo, doing, or done.", value);
                    return 1;
                }
                i += 1;
            } else if ([argument isEqualToString:@"--load"]) {
                if (i + 1 >= argc) {
                    NSLog(@"error: missing value for --load");
                    return 1;
                }
                loadPath = [NSString stringWithUTF8String:argv[i + 1]];
                i += 1;
            } else if ([argument isEqualToString:@"--save"]) {
                if (i + 1 >= argc) {
                    NSLog(@"error: missing value for --save");
                    return 1;
                }
                savePath = [NSString stringWithUTF8String:argv[i + 1]];
                i += 1;
            } else {
                NSLog(@"error: unsupported argument '%@'", argument);
                return 1;
            }
        }

        PFTaskFileStore *fileStore = [[PFTaskFileStore alloc] init];
        NSError *error = nil;
        NSArray<PFTask *> *tasks = loadPath != nil
            ? [fileStore loadTasksFromFile:loadPath error:&error]
            : PFSampleTasks();

        if (tasks == nil) {
            NSLog(@"error: %@", error.localizedDescription);
            return 1;
        }

        if (savePath != nil && ![fileStore saveTasks:tasks toFile:savePath error:&error]) {
            NSLog(@"error: %@", error.localizedDescription);
            return 1;
        }

        PFTaskBoard *board = [[PFTaskBoard alloc] initWithTasks:tasks];
        PFConsoleRenderer *renderer = [[PFConsoleRenderer alloc] init];
        [renderer renderBoard:board onlyState:stateFilter];
    }
    return 0;
}
