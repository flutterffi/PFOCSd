#import <Foundation/Foundation.h>

@interface PFThreadSafeCounter : NSObject
- (void)increment;
- (NSInteger)currentValue;
@end

@implementation PFThreadSafeCounter {
    dispatch_queue_t _queue;
    NSInteger _value;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _queue = dispatch_queue_create("com.pfocsd.counter", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)increment {
    dispatch_barrier_sync(_queue, ^{
        self->_value += 1;
    });
}

- (NSInteger)currentValue {
    __block NSInteger snapshot = 0;
    dispatch_sync(_queue, ^{
        snapshot = self->_value;
    });
    return snapshot;
}

@end

int main(int argc, const char * argv[]) {
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
    }
    return 0;
}
