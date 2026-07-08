#import <Foundation/Foundation.h>

typedef void (^PFLessonEventHandler)(NSString *message);

@interface PFLessonImportOperation : NSOperation

- (instancetype)initWithTaskName:(NSString *)taskName
                       steps:(NSArray<NSString *> *)steps
                eventHandler:(PFLessonEventHandler)eventHandler;

@property (nonatomic, copy, readonly) NSString *taskName;

@end

@interface PFLessonImportOperation ()

@property (nonatomic, copy, readwrite) NSString *taskName;
@property (nonatomic, copy) NSArray<NSString *> *steps;
@property (nonatomic, copy) PFLessonEventHandler eventHandler;

@end

@implementation PFLessonImportOperation

- (instancetype)initWithTaskName:(NSString *)taskName
                       steps:(NSArray<NSString *> *)steps
                eventHandler:(PFLessonEventHandler)eventHandler {
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
            self.eventHandler([NSString stringWithFormat:@"%@ cancelled at %@", self.taskName, step]);
            return;
        }

        [NSThread sleepForTimeInterval:0.04];
        self.eventHandler([NSString stringWithFormat:@"%@ finished %@", self.taskName, step]);
    }

    self.eventHandler([NSString stringWithFormat:@"%@ completed", self.taskName]);
}

@end

static PFLessonImportOperation *PFMakeOperation(NSString *taskName,
                                                NSArray<NSString *> *steps,
                                                PFLessonEventHandler eventHandler) {
    return [[PFLessonImportOperation alloc] initWithTaskName:taskName steps:steps eventHandler:eventHandler];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"Lesson: Operation cancellation and backpressure");

        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 2;

        dispatch_semaphore_t producerGate = dispatch_semaphore_create(2);
        PFLessonEventHandler eventHandler = ^(NSString *message) {
            NSLog(@"%@", message);
        };

        NSArray<PFLessonImportOperation *> *operations = @[
            PFMakeOperation(@"users", @[@"decode", @"validate", @"persist"], eventHandler),
            PFMakeOperation(@"projects", @[@"decode", @"linkOwner", @"persist"], eventHandler),
            PFMakeOperation(@"comments", @[@"decode", @"dedupe", @"persist"], eventHandler),
            PFMakeOperation(@"attachments", @[@"decode", @"thumbnail", @"persist"], eventHandler),
        ];

        [operations[2] addDependency:operations[0]];
        [operations[3] addDependency:operations[1]];

        for (PFLessonImportOperation *operation in operations) {
            dispatch_semaphore_wait(producerGate, DISPATCH_TIME_FOREVER);

            __weak PFLessonImportOperation *weakOperation = operation;
            operation.completionBlock = ^{
                PFLessonImportOperation *strongOperation = weakOperation;
                NSLog(@"completion observed for %@", strongOperation.taskName);
                dispatch_semaphore_signal(producerGate);
            };

            [queue addOperation:operation];
        }

        [operations[2] cancel];
        NSLog(@"requested cancellation for %@", operations[2].taskName);

        [queue waitUntilAllOperationsAreFinished];
        NSLog(@"Try next: replace the semaphore with a producer state machine or retry queue.");
    }
    return 0;
}
