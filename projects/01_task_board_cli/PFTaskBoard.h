#import <Foundation/Foundation.h>
#import "PFTask.h"

@interface PFTaskBoard : NSObject
@property (nonatomic, copy, readonly) NSArray<PFTask *> *tasks;
- (instancetype)initWithTasks:(NSArray<PFTask *> *)tasks;
- (NSDictionary<NSNumber *, NSArray<PFTask *> *> *)groupedTasksByState;
- (NSArray<PFTask *> *)tasksForState:(PFTaskState)state;
@end
