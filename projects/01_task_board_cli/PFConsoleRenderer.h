#import <Foundation/Foundation.h>
#import "PFTaskBoard.h"

@interface PFConsoleRenderer : NSObject
- (void)renderBoard:(PFTaskBoard * _Nonnull)board;
- (void)renderBoard:(PFTaskBoard * _Nonnull)board onlyState:(nullable NSNumber *)stateFilter;
@end
