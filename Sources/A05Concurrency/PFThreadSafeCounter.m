#import "PFThreadSafeCounter.h"

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
