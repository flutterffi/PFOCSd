#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PFTaskScoring <NSObject>
- (NSInteger)scoreForTask:(NSString *)task tags:(NSArray<NSString *> *)tags;
@end

@interface NSString (PFTrimmedLabel)
- (NSString *)pf_trimmedLabel;
@end

@interface PFWeightedScorer : NSObject <PFTaskScoring>
@end

NS_ASSUME_NONNULL_END
