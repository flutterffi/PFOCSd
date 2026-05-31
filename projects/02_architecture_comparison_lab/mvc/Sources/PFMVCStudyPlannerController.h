#import <Foundation/Foundation.h>
#import "PFMVCStudyTaskStore.h"

NS_ASSUME_NONNULL_BEGIN

@interface PFMVCStudyPlannerController : NSObject
@property (nonatomic, strong) PFMVCStudyTaskStore *store;
@property (nonatomic, copy) NSArray<PFMVCStudyTask *> *tasks;
- (instancetype)initWithStore:(PFMVCStudyTaskStore *)store;
- (void)bootstrap;
- (void)addTaskWithTitle:(NSString *)title
                   notes:(NSString *)notes
                    tags:(NSArray<NSString *> *)tags
                priority:(NSInteger)priority
        estimatedMinutes:(NSInteger)estimatedMinutes;
- (void)markTaskBlockedAtIndex:(NSUInteger)index;
- (void)markTaskDoneAtIndex:(NSUInteger)index;
- (NSArray<PFMVCStudyTask *> *)tasksFilteredByTag:(nullable NSString *)tag;
- (NSArray<PFMVCStudyTask *> *)tasksSortedByPriorityFromTasks:(NSArray<PFMVCStudyTask *> *)tasks;
- (nullable NSString *)saveCurrentTasks:(NSError **)error;
- (BOOL)reloadTasksFromPath:(NSString *)path error:(NSError **)error;
- (void)renderTasks:(NSArray<PFMVCStudyTask *> *)tasks title:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
