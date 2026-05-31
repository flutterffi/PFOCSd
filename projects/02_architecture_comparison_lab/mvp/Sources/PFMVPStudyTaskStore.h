#import <Foundation/Foundation.h>
#import "PFMVPStudyTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface PFMVPStudyTaskStore : NSObject
- (NSArray<PFMVPStudyTask *> *)defaultTasks;
- (nullable NSString *)saveTasks:(NSArray<PFMVPStudyTask *> *)tasks error:(NSError **)error;
- (nullable NSArray<PFMVPStudyTask *> *)loadTasksFromPath:(NSString *)path error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
