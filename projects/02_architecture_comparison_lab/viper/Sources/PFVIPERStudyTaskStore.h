#import <Foundation/Foundation.h>
#import "PFVIPERStudyTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface PFVIPERStudyTaskStore : NSObject
- (NSArray<PFVIPERStudyTask *> *)defaultTasks;
- (void)simulateNextSaveFailure;
- (nullable NSString *)saveTasks:(NSArray<PFVIPERStudyTask *> *)tasks error:(NSError **)error;
- (nullable NSArray<PFVIPERStudyTask *> *)loadTasksFromPath:(NSString *)path error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
