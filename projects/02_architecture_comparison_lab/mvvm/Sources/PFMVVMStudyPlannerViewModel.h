#import <Foundation/Foundation.h>
#import "PFMVVMStudyTaskStore.h"
#import "PFMVVMStudyTaskViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PFMVVMStudyPlannerViewModel : NSObject
@property (nonatomic, strong) PFMVVMStudyTaskStore *store;
@property (nonatomic, copy) NSArray<PFMVVMStudyTask *> *tasks;
- (instancetype)initWithStore:(PFMVVMStudyTaskStore *)store;
- (void)bootstrap;
- (void)addTaskWithTitle:(NSString *)title
                   notes:(NSString *)notes
                    tags:(NSArray<NSString *> *)tags
                priority:(NSInteger)priority
        estimatedMinutes:(NSInteger)estimatedMinutes;
- (void)markTaskBlockedAtIndex:(NSUInteger)index;
- (void)markTaskDoneAtIndex:(NSUInteger)index;
- (void)editTaskAtIndex:(NSUInteger)index estimatedMinutes:(NSInteger)estimatedMinutes;
- (NSArray<PFMVVMStudyTaskViewModel *> *)taskViewModelsFilteredByTag:(nullable NSString *)tag;
- (NSArray<PFMVVMStudyTaskViewModel *> *)taskViewModelsFilteredByTag:(nullable NSString *)tag
                                                               state:(nullable NSNumber *)state;
- (NSArray<PFMVVMStudyTaskViewModel *> *)prioritySortedTaskViewModels;
- (NSString *)emptyMessageForTag:(nullable NSString *)tag state:(nullable NSNumber *)state;
- (void)simulateNextSaveFailure;
- (NSString *)saveFeedbackMessageForPath:(nullable NSString *)path error:(nullable NSError *)error;
- (nullable NSString *)saveCurrentTasks:(NSError **)error;
- (BOOL)reloadTasksFromPath:(NSString *)path error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
