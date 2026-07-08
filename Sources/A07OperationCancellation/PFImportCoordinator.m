#import "PFImportCoordinator.h"

#import "PFControlledImportOperation.h"

@interface PFImportCoordinator ()

@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic) dispatch_semaphore_t producerGate;

@end

@implementation PFImportCoordinator

- (instancetype)init {
    self = [super init];
    if (self) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 2;
        _producerGate = dispatch_semaphore_create(2);
    }
    return self;
}

- (void)runScenario {
    NSArray<PFControlledImportOperation *> *operations = @[
        [self operationWithName:@"import.users" steps:@[@"decode", @"validate", @"persist"]],
        [self operationWithName:@"import.projects" steps:@[@"decode", @"linkOwner", @"persist"]],
        [self operationWithName:@"import.comments" steps:@[@"decode", @"dedupe", @"persist"]],
        [self operationWithName:@"import.attachments" steps:@[@"decode", @"thumbnail", @"persist"]],
    ];

    PFControlledImportOperation *users = operations[0];
    PFControlledImportOperation *projects = operations[1];
    PFControlledImportOperation *comments = operations[2];
    PFControlledImportOperation *attachments = operations[3];

    [comments addDependency:users];
    [attachments addDependency:projects];

    for (PFControlledImportOperation *operation in operations) {
        dispatch_semaphore_wait(self.producerGate, DISPATCH_TIME_FOREVER);

        __weak typeof(self) weakSelf = self;
        __weak PFControlledImportOperation *weakOperation = operation;
        operation.completionBlock = ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            PFControlledImportOperation *strongOperation = weakOperation;
            NSLog(@"completion observed for %@", strongOperation.taskName);
            dispatch_semaphore_signal(strongSelf.producerGate);
        };

        [self.queue addOperation:operation];
    }

    [comments cancel];
    NSLog(@"requested cancellation for %@", comments.taskName);

    [self.queue waitUntilAllOperationsAreFinished];
    NSLog(@"all operations drained");
}

- (PFControlledImportOperation *)operationWithName:(NSString *)taskName
                                             steps:(NSArray<NSString *> *)steps {
    return [[PFControlledImportOperation alloc] initWithTaskName:taskName
                                                           steps:steps
                                                    eventHandler:^(NSString *message) {
        NSLog(@"%@", message);
    }];
}

@end
