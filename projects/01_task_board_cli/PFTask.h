#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PFTaskState) {
    PFTaskStateTodo,
    PFTaskStateDoing,
    PFTaskStateDone
};

FOUNDATION_EXPORT NSString * PFTaskStateLabel(PFTaskState state);
FOUNDATION_EXPORT NSNumber * _Nullable PFTaskStateNumberFromLabel(NSString *label);

@interface PFTask : NSObject
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSArray<NSString *> *tags;
@property (nonatomic, assign, readonly) PFTaskState state;
- (instancetype)initWithTitle:(NSString *)title
                         tags:(NSArray<NSString *> *)tags
                        state:(PFTaskState)state;
- (NSDictionary<NSString *, id> *)dictionaryRepresentation;
@end

NS_ASSUME_NONNULL_END
