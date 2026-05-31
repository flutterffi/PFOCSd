#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PFVIPERStudyTaskState) {
    PFVIPERStudyTaskStateTodo,
    PFVIPERStudyTaskStateDone
};

FOUNDATION_EXPORT NSString *PFVIPERStudyTaskStateLabel(PFVIPERStudyTaskState state);

@interface PFVIPERStudyTask : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *notes;
@property (nonatomic, copy) NSArray<NSString *> *tags;
@property (nonatomic, assign) NSInteger estimatedMinutes;
@property (nonatomic, assign) PFVIPERStudyTaskState state;

- (instancetype)initWithTitle:(NSString *)title
                        notes:(NSString *)notes
                         tags:(NSArray<NSString *> *)tags
             estimatedMinutes:(NSInteger)estimatedMinutes
                        state:(PFVIPERStudyTaskState)state;
- (NSDictionary<NSString *, id> *)dictionaryRepresentation;
@end

NS_ASSUME_NONNULL_END
