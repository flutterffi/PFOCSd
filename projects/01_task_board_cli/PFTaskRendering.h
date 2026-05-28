#import <Foundation/Foundation.h>
#import "PFTaskBoard.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PFTaskRendering <NSObject>
- (void)renderBoard:(PFTaskBoard *)board onlyState:(nullable NSNumber *)stateFilter;
@end

NS_ASSUME_NONNULL_END
