#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PFMVPStudyTaskState) {
    PFMVPStudyTaskStateTodo,
    PFMVPStudyTaskStateBlocked,
    PFMVPStudyTaskStateDone
};

FOUNDATION_EXPORT NSString *PFMVPStudyTaskStateLabel(PFMVPStudyTaskState state);

@interface PFMVPStudyTask : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *notes;
@property (nonatomic, copy) NSArray<NSString *> *tags;
@property (nonatomic, assign) NSInteger priority;
@property (nonatomic, assign) NSInteger estimatedMinutes;
@property (nonatomic, assign) PFMVPStudyTaskState state;
- (instancetype)initWithTitle:(NSString *)title
                        notes:(NSString *)notes
                         tags:(NSArray<NSString *> *)tags
                     priority:(NSInteger)priority
             estimatedMinutes:(NSInteger)estimatedMinutes
                        state:(PFMVPStudyTaskState)state;
- (NSDictionary<NSString *, id> *)dictionaryRepresentation;
@end

NS_ASSUME_NONNULL_END
