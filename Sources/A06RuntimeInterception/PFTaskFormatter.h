#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PFTaskFormatter : NSObject
@property (nonatomic, copy) NSString *prefix;
- (NSString *)renderPlainTask:(NSString *)task;
- (NSString *)renderBulletTask:(NSString *)task;
@end

NS_ASSUME_NONNULL_END
