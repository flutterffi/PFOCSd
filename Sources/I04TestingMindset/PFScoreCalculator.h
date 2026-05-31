#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PFScoreCalculator : NSObject
- (NSInteger)weightedScoreWithDifficulty:(NSInteger)difficulty tagsCount:(NSInteger)tagsCount;
@end

NS_ASSUME_NONNULL_END
