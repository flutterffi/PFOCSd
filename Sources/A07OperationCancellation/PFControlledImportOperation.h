#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^PFControlledImportEventHandler)(NSString *message);

@interface PFControlledImportOperation : NSOperation

- (instancetype)initWithTaskName:(NSString *)taskName
                           steps:(NSArray<NSString *> *)steps
                    eventHandler:(PFControlledImportEventHandler)eventHandler NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@property (nonatomic, copy, readonly) NSString *taskName;

@end

NS_ASSUME_NONNULL_END
