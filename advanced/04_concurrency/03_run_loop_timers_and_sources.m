#import <Foundation/Foundation.h>

typedef void (^PFLessonRunLoopLogger)(NSString *message);

@interface PFLessonPulse : NSObject

- (instancetype)initWithTaskName:(NSString *)taskName
                        interval:(NSTimeInterval)interval
                      fireTarget:(NSInteger)fireTarget
                          logger:(PFLessonRunLoopLogger)logger;

- (void)attachToRunLoop:(NSRunLoop *)runLoop;
- (void)invalidate;

@property (nonatomic, copy, readonly) NSString *taskName;

@end

@interface PFLessonPulse ()

@property (nonatomic, copy, readwrite) NSString *taskName;
@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, assign) NSInteger fireTarget;
@property (nonatomic, assign) NSInteger fireCount;
@property (nonatomic, copy) PFLessonRunLoopLogger logger;
@property (nonatomic, strong, nullable) NSTimer *timer;

@end

@implementation PFLessonPulse

- (instancetype)initWithTaskName:(NSString *)taskName
                        interval:(NSTimeInterval)interval
                      fireTarget:(NSInteger)fireTarget
                          logger:(PFLessonRunLoopLogger)logger {
    self = [super init];
    if (self) {
        _taskName = [taskName copy];
        _interval = interval;
        _fireTarget = fireTarget;
        _fireCount = 0;
        _logger = [logger copy];
    }
    return self;
}

- (void)attachToRunLoop:(NSRunLoop *)runLoop {
    self.logger([NSString stringWithFormat:@"%@ scheduled", self.taskName]);

    self.timer = [NSTimer timerWithTimeInterval:self.interval
                                         target:self
                                       selector:@selector(handleTimerFire:)
                                       userInfo:nil
                                        repeats:YES];
    [runLoop addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)handleTimerFire:(NSTimer *)timer {
    self.fireCount += 1;
    self.logger([NSString stringWithFormat:@"%@ fire %ld", self.taskName, (long)self.fireCount]);

    if (self.fireCount >= self.fireTarget) {
        [timer invalidate];
        self.timer = nil;
        self.logger([NSString stringWithFormat:@"%@ completed", self.taskName]);
    }
}

- (void)invalidate {
    if (self.timer == nil) {
        return;
    }

    [self.timer invalidate];
    self.timer = nil;
    self.logger([NSString stringWithFormat:@"%@ invalidated manually", self.taskName]);
}

@end

@interface PFLessonRunLoopWorker : NSObject

- (void)start;
- (void)schedulePulse:(PFLessonPulse *)pulse;
- (void)stop;

@end

@interface PFLessonRunLoopWorker ()

@property (nonatomic, strong) NSThread *thread;
@property (nonatomic, strong) NSPort *keepAlivePort;
@property (nonatomic, strong) NSMutableArray<PFLessonPulse *> *pulses;
@property (nonatomic, strong) NSCondition *condition;
@property (nonatomic, assign) BOOL ready;
@property (nonatomic, assign) BOOL shouldStop;

@end

@implementation PFLessonRunLoopWorker

- (instancetype)init {
    self = [super init];
    if (self) {
        _keepAlivePort = [[NSMachPort alloc] init];
        _pulses = [[NSMutableArray alloc] init];
        _condition = [[NSCondition alloc] init];
    }
    return self;
}

- (void)start {
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadMain) object:nil];
    self.thread.name = @"lesson.runloop.worker";
    [self.thread start];

    [self.condition lock];
    while (!self.ready) {
        [self.condition wait];
    }
    [self.condition unlock];
}

- (void)schedulePulse:(PFLessonPulse *)pulse {
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

- (void)threadMain {
    @autoreleasepool {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:self.keepAlivePort forMode:NSDefaultRunLoopMode];

        [self.condition lock];
        self.ready = YES;
        [self.condition signal];
        [self.condition unlock];

        NSLog(@"lesson run loop started");

        while (!self.shouldStop && [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.05]]) {
            // Keep the worker alive while timers and selectors are delivered.
        }

        NSLog(@"lesson run loop stopped");
    }
}

- (void)installPulse:(PFLessonPulse *)pulse {
    [self.pulses addObject:pulse];
    [pulse attachToRunLoop:[NSRunLoop currentRunLoop]];
}

- (void)stopRunLoop {
    self.shouldStop = YES;

    for (PFLessonPulse *pulse in self.pulses) {
        [pulse invalidate];
    }

    [self.pulses removeAllObjects];
    CFRunLoopStop([[NSRunLoop currentRunLoop] getCFRunLoop]);
}

@end

int main(void) {
    @autoreleasepool {
        NSLog(@"Lesson: Run loop timers and sources");

        PFLessonRunLoopLogger logger = ^(NSString *message) {
            NSLog(@"%@", message);
        };

        PFLessonRunLoopWorker *worker = [[PFLessonRunLoopWorker alloc] init];
        [worker start];

        [worker schedulePulse:[[PFLessonPulse alloc] initWithTaskName:@"heartbeat"
                                                             interval:0.05
                                                           fireTarget:3
                                                               logger:logger]];
        [worker schedulePulse:[[PFLessonPulse alloc] initWithTaskName:@"watchdog"
                                                             interval:0.08
                                                           fireTarget:2
                                                               logger:logger]];

        [NSThread sleepForTimeInterval:0.35];
        [worker stop];

        NSLog(@"Try next: add a manual wakeup event or compare default mode with common modes.");
    }
    return 0;
}
