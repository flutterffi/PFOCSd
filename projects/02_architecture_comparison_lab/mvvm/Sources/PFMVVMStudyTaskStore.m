#import "PFMVVMStudyTaskStore.h"

static NSString *PFMVVMPlannerPath(void) {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:@"pfocsd-mvvm-planner.json"];
}

static PFMVVMStudyTaskState PFMVVMStateFromString(NSString *value) {
    if ([value isEqualToString:@"done"]) {
        return PFMVVMStudyTaskStateDone;
    }
    if ([value isEqualToString:@"blocked"]) {
        return PFMVVMStudyTaskStateBlocked;
    }
    return PFMVVMStudyTaskStateTodo;
}

@implementation PFMVVMStudyTaskStore

- (NSArray<PFMVVMStudyTask *> *)defaultTasks {
    return @[
        [[PFMVVMStudyTask alloc] initWithTitle:@"Review ARC"
                                         notes:@"compare weak and copy"
                                          tags:@[@"memory", @"objc"]
                              estimatedMinutes:25
                                         state:PFMVVMStudyTaskStateTodo],
        [[PFMVVMStudyTask alloc] initWithTitle:@"Practice KVC"
                                         notes:@"map payload into model"
                                          tags:@[@"data-flow", @"kvc"]
                              estimatedMinutes:30
                                         state:PFMVVMStudyTaskStateBlocked],
    ];
}

- (nullable NSString *)saveTasks:(NSArray<PFMVVMStudyTask *> *)tasks error:(NSError **)error {
    NSMutableArray<NSDictionary<NSString *, id> *> *payload = [NSMutableArray arrayWithCapacity:tasks.count];
    for (PFMVVMStudyTask *task in tasks) {
        [payload addObject:[task dictionaryRepresentation]];
    }

    NSData *data = [NSJSONSerialization dataWithJSONObject:payload
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:error];
    if (data == nil) {
        return nil;
    }

    NSString *path = PFMVVMPlannerPath();
    if (![data writeToFile:path options:NSDataWritingAtomic error:error]) {
        return nil;
    }
    return path;
}

- (nullable NSArray<PFMVVMStudyTask *> *)loadTasksFromPath:(NSString *)path error:(NSError **)error {
    NSData *data = [NSData dataWithContentsOfFile:path options:0 error:error];
    if (data == nil) {
        return nil;
    }

    NSArray<NSDictionary<NSString *, id> *> *payload = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
    if (![payload isKindOfClass:[NSArray class]]) {
        return nil;
    }

    NSMutableArray<PFMVVMStudyTask *> *tasks = [NSMutableArray arrayWithCapacity:payload.count];
    for (NSDictionary<NSString *, id> *item in payload) {
        [tasks addObject:[[PFMVVMStudyTask alloc] initWithTitle:item[@"title"] ?: @"untitled"
                                                          notes:item[@"notes"] ?: @""
                                                           tags:item[@"tags"] ?: @[]
                                               estimatedMinutes:[item[@"estimatedMinutes"] integerValue]
                                                          state:PFMVVMStateFromString(item[@"state"] ?: @"todo")]];
    }
    return tasks;
}

@end
