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
        estimatedMinutes:(NSInteger)estimatedMinutes;
- (void)markTaskDoneAtIndex:(NSUInteger)index;
- (NSArray<PFMVVMStudyTaskViewModel *> *)taskViewModelsFilteredByTag:(nullable NSString *)tag;
- (nullable NSString *)saveCurrentTasks:(NSError **)error;
- (BOOL)reloadTasksFromPath:(NSString *)path error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
