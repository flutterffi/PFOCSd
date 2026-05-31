#import <Foundation/Foundation.h>
#import "PFMVVMStudyTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface PFMVVMStudyTaskStore : NSObject
- (NSArray<PFMVVMStudyTask *> *)defaultTasks;
- (nullable NSString *)saveTasks:(NSArray<PFMVVMStudyTask *> *)tasks error:(NSError **)error;
- (nullable NSArray<PFMVVMStudyTask *> *)loadTasksFromPath:(NSString *)path error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
