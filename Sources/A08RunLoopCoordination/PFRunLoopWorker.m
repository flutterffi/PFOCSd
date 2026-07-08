#import "PFRunLoopWorker.h"

@interface PFRunLoopWorker ()

@property (nonatomic, strong) NSThread *thread;
@property (nonatomic, strong) NSPort *keepAlivePort;
@property (nonatomic, strong) NSMutableArray<PFRunLoopPulse *> *pulses;
@property (nonatomic, strong) NSCondition *stateCondition;
@property (nonatomic, assign) BOOL ready;
@property (nonatomic, assign) BOOL shouldStop;

@end

@implementation PFRunLoopWorker

- (instancetype)init {
    self = [super init];
    if (self) {
        _keepAlivePort = [[NSMachPort alloc] init];
        _pulses = [[NSMutableArray alloc] init];
        _stateCondition = [[NSCondition alloc] init];
        _ready = NO;
        _shouldStop = NO;
    }
    return self;
}

- (void)start {
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadEntryPoint) object:nil];
    self.thread.name = @"pfocsd.runloop.worker";
    [self.thread start];

    [self.stateCondition lock];
    while (!self.ready) {
        [self.stateCondition wait];
    }
    [self.stateCondition unlock];
}

- (void)schedulePulseWithName:(NSString *)name
                     interval:(NSTimeInterval)interval
                   fireTarget:(NSInteger)fireTarget {
    PFRunLoopPulse *pulse = [[PFRunLoopPulse alloc] initWithName:name
                                                        interval:interval
                                                      fireTarget:fireTarget
                                                    eventHandler:^(NSString *message) {
        NSLog(@"%@", message);
    }];

    [self performSelector:@selector(installPulse:)
                 onThread:self.thread
               withObject:pulse
            waitUntilDone:YES];
}

- (void)stop {
    [self performSelector:@selector(stopRunLoop)
                 onThread:self.thread
               withObject:nil
            waitUntilDone:YES];
}

- (void)threadEntryPoint {
    @autoreleasepool {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:self.keepAlivePort forMode:NSDefaultRunLoopMode];

        [self.stateCondition lock];
        self.ready = YES;
        [self.stateCondition signal];
        [self.stateCondition unlock];

        NSLog(@"run loop worker started");

        while (!self.shouldStop && [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.05]]) {
            // Keep spinning so scheduled selectors and timers can be observed in one place.
        }

        NSLog(@"run loop worker stopped");
    }
}

- (void)installPulse:(PFRunLoopPulse *)pulse {
    [self.pulses addObject:pulse];
    [pulse attachToRunLoop:[NSRunLoop currentRunLoop]];
}

- (void)stopRunLoop {
    self.shouldStop = YES;

    for (PFRunLoopPulse *pulse in self.pulses) {
        [pulse invalidate];
    }

    [self.pulses removeAllObjects];
    CFRunLoopStop([[NSRunLoop currentRunLoop] getCFRunLoop]);
}

@end
