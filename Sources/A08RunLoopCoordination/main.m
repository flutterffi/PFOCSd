#import <Foundation/Foundation.h>

#import "PFRunLoopWorker.h"

int main(void) {
    @autoreleasepool {
        NSLog(@"A08RunLoopCoordination");

        PFRunLoopWorker *worker = [[PFRunLoopWorker alloc] init];
        [worker start];

        [worker schedulePulseWithName:@"heartbeat" interval:0.05 fireTarget:3];
        [worker schedulePulseWithName:@"watchdog" interval:0.08 fireTarget:2];

        [NSThread sleepForTimeInterval:0.35];
        [worker stop];

        NSLog(@"Exercise: add a custom input source or move one timer to a different mode.");
    }
    return 0;
}
