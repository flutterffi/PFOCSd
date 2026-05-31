#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PFTopicLibrary : NSObject
- (NSArray<NSString *> *)topics;
- (NSDictionary<NSString *, NSString *> *)goalByTopic;
@end

NS_ASSUME_NONNULL_END
