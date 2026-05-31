#import "PFTaskService.h"

@implementation PFTaskService

- (instancetype)initWithScorer:(id<PFTaskScoring>)scorer {
    self = [super init];
    if (self) {
        _scorer = scorer;
    }
    return self;
}

- (NSDictionary<NSString *, id> *)summaryForTask:(NSString *)task
                                            tags:(NSArray<NSString *> *)tags {
    NSString *cleanedTask = [task pf_trimmedLabel];
    return @{
        @"task": cleanedTask,
        @"tags": tags,
        @"score": @([self.scorer scoreForTask:cleanedTask tags:tags])
    };
}

@end
