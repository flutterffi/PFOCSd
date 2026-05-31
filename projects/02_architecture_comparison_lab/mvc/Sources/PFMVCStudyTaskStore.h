#import <Foundation/Foundation.h>
#import "PFMVCStudyTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface PFMVCStudyTaskStore : NSObject
- (NSArray<PFMVCStudyTask *> *)defaultTasks;
- (void)simulateNextSaveFailure;
- (nullable NSString *)saveTasks:(NSArray<PFMVCStudyTask *> *)tasks error:(NSError **)error;
- (nullable NSArray<PFMVCStudyTask *> *)loadTasksFromPath:(NSString *)path error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
