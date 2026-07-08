#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^PFRunLoopPulseEventHandler)(NSString *message);

@interface PFRunLoopPulse : NSObject

- (instancetype)initWithName:(NSString *)name
                    interval:(NSTimeInterval)interval
                  fireTarget:(NSInteger)fireTarget
                eventHandler:(PFRunLoopPulseEventHandler)eventHandler NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) NSTimeInterval interval;
@property (nonatomic, assign, readonly) NSInteger fireTarget;
@property (nonatomic, assign, readonly) NSInteger fireCount;

- (void)attachToRunLoop:(NSRunLoop *)runLoop;
- (void)invalidate;

@end

NS_ASSUME_NONNULL_END
