#import "PFRunLoopPulse.h"

@interface PFRunLoopPulse ()

@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, assign, readwrite) NSTimeInterval interval;
@property (nonatomic, assign, readwrite) NSInteger fireTarget;
@property (nonatomic, assign, readwrite) NSInteger fireCount;
@property (nonatomic, copy) PFRunLoopPulseEventHandler eventHandler;
@property (nonatomic, strong, nullable) NSTimer *timer;

@end

@implementation PFRunLoopPulse

- (instancetype)initWithName:(NSString *)name
                    interval:(NSTimeInterval)interval
                  fireTarget:(NSInteger)fireTarget
                eventHandler:(PFRunLoopPulseEventHandler)eventHandler {
    self = [super init];
    if (self) {
        _name = [name copy];
        _interval = interval;
        _fireTarget = fireTarget;
        _fireCount = 0;
        _eventHandler = [eventHandler copy];
    }
    return self;
}

- (void)attachToRunLoop:(NSRunLoop *)runLoop {
    if (self.timer != nil) {
        return;
    }

    self.eventHandler([NSString stringWithFormat:@"%@ scheduled on run loop", self.name]);

    self.timer = [NSTimer timerWithTimeInterval:self.interval
                                         target:self
                                       selector:@selector(handleTimerFire:)
                                       userInfo:nil
                                        repeats:YES];
    [runLoop addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)handleTimerFire:(NSTimer *)timer {
    self.fireCount += 1;
    self.eventHandler([NSString stringWithFormat:@"%@ fire %ld", self.name, (long)self.fireCount]);

    if (self.fireCount >= self.fireTarget) {
        [timer invalidate];
        self.timer = nil;
        self.eventHandler([NSString stringWithFormat:@"%@ reached target and invalidated timer", self.name]);
    }
}

- (void)invalidate {
    if (self.timer == nil) {
        return;
    }

    [self.timer invalidate];
    self.timer = nil;
    self.eventHandler([NSString stringWithFormat:@"%@ invalidated manually", self.name]);
}

@end
