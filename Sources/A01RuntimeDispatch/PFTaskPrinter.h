#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PFTaskPrinter : NSObject
@property (nonatomic, copy) NSString *prefix;
- (NSString *)renderTask:(NSString *)task;
- (NSString *)renderUppercaseTask:(NSString *)task;
@end

FOUNDATION_EXPORT void PFPrintMethodAvailability(id target, SEL selector);

NS_ASSUME_NONNULL_END
