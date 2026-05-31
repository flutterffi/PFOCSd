#import "PFPipelineStep.h"

@implementation PFPipelineStep

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = [name copy];
    }
    return self;
}

- (NSBlockOperation *)operationWithLogMessage:(NSString *)message {
    return [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@ -> %@", self.name, message);
    }];
}

@end
