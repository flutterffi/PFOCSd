#import <Foundation/Foundation.h>
#import "PFThreadSafeCounter.h"

int main(void) {
    @autoreleasepool {
        PFThreadSafeCounter *counter = [[PFThreadSafeCounter alloc] init];
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t workerQueue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);

        for (NSInteger i = 0; i < 20; i++) {
            dispatch_group_async(group, workerQueue, ^{
                [counter increment];
            });
        }

        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);

        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 2;

        NSBlockOperation *first = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"operation 1 -> inspect queue behavior");
        }];

        NSBlockOperation *second = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"operation 2 -> compare with GCD");
        }];

        [second addDependency:first];
        [queue addOperations:@[first, second] waitUntilFinished:YES];

        NSLog(@"final counter -> %ld", (long)[counter currentValue]);

        // Practice idea: add reset support and verify it under repeated runs.
    }
    return 0;
}
