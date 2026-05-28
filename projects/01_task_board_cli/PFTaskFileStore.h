#import <Foundation/Foundation.h>
#import "PFTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface PFTaskFileStore : NSObject
- (nullable NSArray<PFTask *> *)loadTasksFromFile:(NSString *)path error:(NSError **)error;
- (BOOL)saveTasks:(NSArray<PFTask *> *)tasks toFile:(NSString *)path error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
