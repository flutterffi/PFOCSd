#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PFProfile : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger streakDays;
@property (nonatomic, strong) NSMutableArray<NSString *> *focusTopics;
@end

@interface PFProfileObserver : NSObject
@end

FOUNDATION_EXPORT PFProfile *PFProfileFromDictionary(NSDictionary<NSString *, id> *payload);

NS_ASSUME_NONNULL_END
