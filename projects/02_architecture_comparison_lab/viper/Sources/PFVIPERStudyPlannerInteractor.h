#import <Foundation/Foundation.h>
#import "PFVIPERStudyTaskStore.h"

NS_ASSUME_NONNULL_BEGIN

@interface PFVIPERStudyPlannerInteractor : NSObject
@property (nonatomic, strong, readonly) PFVIPERStudyTaskStore *store;
@property (nonatomic, copy, readonly) NSArray<PFVIPERStudyTask *> *tasks;

- (instancetype)initWithStore:(PFVIPERStudyTaskStore *)store;
- (void)bootstrap;
- (void)addTaskWithTitle:(NSString *)title
                   notes:(NSString *)notes
                    tags:(NSArray<NSString *> *)tags
                priority:(NSInteger)priority
        estimatedMinutes:(NSInteger)estimatedMinutes;
- (void)markTaskBlockedAtIndex:(NSUInteger)index;
- (void)markTaskDoneAtIndex:(NSUInteger)index;
- (NSArray<PFVIPERStudyTask *> *)tasksFilteredByTag:(nullable NSString *)tag;
- (NSArray<PFVIPERStudyTask *> *)prioritySortedTasks;
- (nullable NSString *)saveTasksWithError:(NSError **)error;
- (BOOL)reloadTasksFromPath:(NSString *)path error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
