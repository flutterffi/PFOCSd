#import <Foundation/Foundation.h>
#import "PFTaskRendering.h"

NS_ASSUME_NONNULL_BEGIN

@interface PFConsoleRenderer : NSObject <PFTaskRendering>
- (void)renderBoard:(PFTaskBoard * _Nonnull)board;
- (void)renderBoard:(PFTaskBoard * _Nonnull)board onlyState:(nullable NSNumber *)stateFilter;
@end

NS_ASSUME_NONNULL_END
