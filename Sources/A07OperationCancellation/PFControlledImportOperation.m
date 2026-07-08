#import "PFControlledImportOperation.h"

@interface PFControlledImportOperation ()

@property (nonatomic, copy, readwrite) NSString *taskName;
@property (nonatomic, copy) NSArray<NSString *> *steps;
@property (nonatomic, copy) PFControlledImportEventHandler eventHandler;

@end

@implementation PFControlledImportOperation

- (instancetype)initWithTaskName:(NSString *)taskName
                           steps:(NSArray<NSString *> *)steps
                    eventHandler:(PFControlledImportEventHandler)eventHandler {
    self = [super init];
    if (self) {
        _taskName = [taskName copy];
        _steps = [steps copy];
        _eventHandler = [eventHandler copy];
    }
    return self;
}

- (void)main {
    if (self.cancelled) {
        self.eventHandler([NSString stringWithFormat:@"%@ skipped before start", self.taskName]);
        return;
    }

    self.eventHandler([NSString stringWithFormat:@"%@ started", self.taskName]);

    for (NSString *step in self.steps) {
        if (self.cancelled) {
            self.eventHandler([NSString stringWithFormat:@"%@ cancelled while processing %@", self.taskName, step]);
            return;
        }

        [NSThread sleepForTimeInterval:0.04];
        self.eventHandler([NSString stringWithFormat:@"%@ completed step %@", self.taskName, step]);
    }

    self.eventHandler([NSString stringWithFormat:@"%@ finished", self.taskName]);
}

@end
