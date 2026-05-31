#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PFThreadSafeCounter : NSObject
- (void)increment;
- (NSInteger)currentValue;
@end

NS_ASSUME_NONNULL_END
