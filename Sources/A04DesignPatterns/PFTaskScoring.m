#import "PFTaskScoring.h"

@implementation NSString (PFTrimmedLabel)

- (NSString *)pf_trimmedLabel {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end

@implementation PFWeightedScorer

- (NSInteger)scoreForTask:(NSString *)task tags:(NSArray<NSString *> *)tags {
    NSInteger base = task.length > 20 ? 3 : 1;
    NSInteger tagWeight = (NSInteger)tags.count * 2;
    return base + tagWeight;
}

@end
