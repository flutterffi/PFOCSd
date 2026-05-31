#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PFMVCStudyTaskState) {
    PFMVCStudyTaskStateTodo,
    PFMVCStudyTaskStateBlocked,
    PFMVCStudyTaskStateDone
};

FOUNDATION_EXPORT NSString *PFMVCStudyTaskStateLabel(PFMVCStudyTaskState state);

@interface PFMVCStudyTask : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *notes;
@property (nonatomic, copy) NSArray<NSString *> *tags;
@property (nonatomic, assign) NSInteger estimatedMinutes;
@property (nonatomic, assign) PFMVCStudyTaskState state;
- (instancetype)initWithTitle:(NSString *)title
                        notes:(NSString *)notes
                         tags:(NSArray<NSString *> *)tags
             estimatedMinutes:(NSInteger)estimatedMinutes
                        state:(PFMVCStudyTaskState)state;
- (NSDictionary<NSString *, id> *)dictionaryRepresentation;
@end

NS_ASSUME_NONNULL_END
