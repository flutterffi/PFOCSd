#import <Foundation/Foundation.h>

@protocol PFTaskScoring <NSObject>
- (NSInteger)scoreForTask:(NSString *)task tags:(NSArray<NSString *> *)tags;
@end

@interface NSString (PFTrimmedLabel)
- (NSString *)pf_trimmedLabel;
@end

@implementation NSString (PFTrimmedLabel)

- (NSString *)pf_trimmedLabel {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end

@interface PFWeightedScorer : NSObject <PFTaskScoring>
@end

@implementation PFWeightedScorer

- (NSInteger)scoreForTask:(NSString *)task tags:(NSArray<NSString *> *)tags {
    NSInteger base = task.length > 20 ? 3 : 1;
    NSInteger tagWeight = (NSInteger)tags.count * 2;
    return base + tagWeight;
}

@end

@interface PFTaskService : NSObject
@property (nonatomic, strong) id<PFTaskScoring> scorer;
- (instancetype)initWithScorer:(id<PFTaskScoring>)scorer;
- (NSDictionary<NSString *, id> *)summaryForTask:(NSString *)task
                                            tags:(NSArray<NSString *> *)tags;
@end

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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        PFTaskService *service = [[PFTaskService alloc] initWithScorer:[[PFWeightedScorer alloc] init]];

        NSDictionary<NSString *, id> *summary = [service summaryForTask:@"  design a safer API boundary  "
                                                                   tags:@[@"objc", @"protocol", @"review"]];

        NSLog(@"task summary -> %@", summary);
    }
    return 0;
}
