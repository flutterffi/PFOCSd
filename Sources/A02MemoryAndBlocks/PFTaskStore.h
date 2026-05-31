#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PFTaskStore : NSObject
@property (nonatomic, strong) NSMutableArray<NSString *> *tasks;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy, nullable) void (^changeHandler)(NSString *message);
- (void)addTask:(NSString *)task;
@end

FOUNDATION_EXPORT PFTaskStore *PFMakeTaskStore(void);

NS_ASSUME_NONNULL_END
