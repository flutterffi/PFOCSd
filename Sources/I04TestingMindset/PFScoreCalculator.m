#import "PFScoreCalculator.h"

@implementation PFScoreCalculator

- (NSInteger)weightedScoreWithDifficulty:(NSInteger)difficulty tagsCount:(NSInteger)tagsCount {
    return difficulty * 2 + tagsCount;
}

@end
