#import <Foundation/Foundation.h>

#import "PFRunLoopPulse.h"

NS_ASSUME_NONNULL_BEGIN

@interface PFRunLoopWorker : NSObject

- (void)start;
- (void)schedulePulseWithName:(NSString *)name
                     interval:(NSTimeInterval)interval
                   fireTarget:(NSInteger)fireTarget;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
