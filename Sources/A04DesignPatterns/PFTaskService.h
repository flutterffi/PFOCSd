#import <Foundation/Foundation.h>
#import "PFTaskScoring.h"

NS_ASSUME_NONNULL_BEGIN

@interface PFTaskService : NSObject
@property (nonatomic, strong) id<PFTaskScoring> scorer;
- (instancetype)initWithScorer:(id<PFTaskScoring>)scorer;
- (NSDictionary<NSString *, id> *)summaryForTask:(NSString *)task
                                            tags:(NSArray<NSString *> *)tags;
@end

NS_ASSUME_NONNULL_END
