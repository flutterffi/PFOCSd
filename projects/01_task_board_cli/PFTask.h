#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PFTaskState) {
    PFTaskStateTodo,
    PFTaskStateDoing,
    PFTaskStateDone
};

FOUNDATION_EXPORT NSString *PFTaskStateLabel(PFTaskState state);

@interface PFTask : NSObject
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSArray<NSString *> *tags;
@property (nonatomic, assign, readonly) PFTaskState state;
- (instancetype)initWithTitle:(NSString *)title
                         tags:(NSArray<NSString *> *)tags
                        state:(PFTaskState)state;
@end
