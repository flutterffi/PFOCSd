#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PFPipelineStep : NSObject
@property (nonatomic, copy) NSString *name;
- (instancetype)initWithName:(NSString *)name;
- (NSBlockOperation *)operationWithLogMessage:(NSString *)message;
@end

NS_ASSUME_NONNULL_END
