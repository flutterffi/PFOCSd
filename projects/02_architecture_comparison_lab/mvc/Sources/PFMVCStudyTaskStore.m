#import "PFMVCStudyTaskStore.h"

static NSString *PFMVCPlannerPath(void) {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:@"pfocsd-mvc-planner.json"];
}

static PFMVCStudyTaskState PFMVCStateFromString(NSString *value) {
    return [value isEqualToString:@"done"] ? PFMVCStudyTaskStateDone : PFMVCStudyTaskStateTodo;
}

@implementation PFMVCStudyTaskStore

- (NSArray<PFMVCStudyTask *> *)defaultTasks {
    return @[
        [[PFMVCStudyTask alloc] initWithTitle:@"Review ARC"
                                        notes:@"compare weak and copy"
                                         tags:@[@"memory", @"objc"]
                             estimatedMinutes:25
                                        state:PFMVCStudyTaskStateTodo],
        [[PFMVCStudyTask alloc] initWithTitle:@"Practice KVC"
                                        notes:@"map payload into model"
                                         tags:@[@"data-flow", @"kvc"]
                             estimatedMinutes:30
                                        state:PFMVCStudyTaskStateTodo],
    ];
}

- (nullable NSString *)saveTasks:(NSArray<PFMVCStudyTask *> *)tasks error:(NSError **)error {
    NSMutableArray<NSDictionary<NSString *, id> *> *payload = [NSMutableArray arrayWithCapacity:tasks.count];
    for (PFMVCStudyTask *task in tasks) {
        [payload addObject:[task dictionaryRepresentation]];
    }

    NSData *data = [NSJSONSerialization dataWithJSONObject:payload
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:error];
    if (data == nil) {
        return nil;
    }

    NSString *path = PFMVCPlannerPath();
    if (![data writeToFile:path options:NSDataWritingAtomic error:error]) {
        return nil;
    }
    return path;
}

- (nullable NSArray<PFMVCStudyTask *> *)loadTasksFromPath:(NSString *)path error:(NSError **)error {
    NSData *data = [NSData dataWithContentsOfFile:path options:0 error:error];
    if (data == nil) {
        return nil;
    }

    NSArray<NSDictionary<NSString *, id> *> *payload = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
    if (![payload isKindOfClass:[NSArray class]]) {
        return nil;
    }

    NSMutableArray<PFMVCStudyTask *> *tasks = [NSMutableArray arrayWithCapacity:payload.count];
    for (NSDictionary<NSString *, id> *item in payload) {
        [tasks addObject:[[PFMVCStudyTask alloc] initWithTitle:item[@"title"] ?: @"untitled"
                                                         notes:item[@"notes"] ?: @""
                                                          tags:item[@"tags"] ?: @[]
                                              estimatedMinutes:[item[@"estimatedMinutes"] integerValue]
                                                         state:PFMVCStateFromString(item[@"state"] ?: @"todo")]];
    }
    return tasks;
}

@end
