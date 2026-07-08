#import <Foundation/Foundation.h>
#import "PFTaskFormatter.h"

NS_ASSUME_NONNULL_BEGIN

@interface PFForwardingFormatter : NSObject
- (instancetype)initWithFormatter:(PFTaskFormatter *)formatter;
@end

NS_ASSUME_NONNULL_END
