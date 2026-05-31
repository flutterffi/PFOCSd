#import "PFVIPERStudyTaskStore.h"

static NSString *PFVIPERPlannerPath(void) {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:@"pfocsd-viper-planner.json"];
}

static PFVIPERStudyTaskState PFVIPERStateFromString(NSString *value) {
    return [value isEqualToString:@"done"] ? PFVIPERStudyTaskStateDone : PFVIPERStudyTaskStateTodo;
}

@implementation PFVIPERStudyTaskStore

- (NSArray<PFVIPERStudyTask *> *)defaultTasks {
    return @[
        [[PFVIPERStudyTask alloc] initWithTitle:@"Review VIPER boundaries"
                                          notes:@"trace which layer owns each change"
                                           tags:@[@"architecture", @"viper"]
                               estimatedMinutes:35
                                          state:PFVIPERStudyTaskStateTodo],
        [[PFVIPERStudyTask alloc] initWithTitle:@"Refactor persistence flow"
                                          notes:@"keep storage details inside the interactor"
                                           tags:@[@"persistence", @"interactor"]
                               estimatedMinutes:30
                                          state:PFVIPERStudyTaskStateTodo],
    ];
}

- (nullable NSString *)saveTasks:(NSArray<PFVIPERStudyTask *> *)tasks error:(NSError **)error {
    NSMutableArray<NSDictionary<NSString *, id> *> *payload = [NSMutableArray arrayWithCapacity:tasks.count];
    for (PFVIPERStudyTask *task in tasks) {
        [payload addObject:[task dictionaryRepresentation]];
    }

    NSData *data = [NSJSONSerialization dataWithJSONObject:payload
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:error];
    if (data == nil) {
        return nil;
    }

    NSString *path = PFVIPERPlannerPath();
    if (![data writeToFile:path options:NSDataWritingAtomic error:error]) {
        return nil;
    }
    return path;
}

- (nullable NSArray<PFVIPERStudyTask *> *)loadTasksFromPath:(NSString *)path error:(NSError **)error {
    NSData *data = [NSData dataWithContentsOfFile:path options:0 error:error];
    if (data == nil) {
        return nil;
    }

    id payload = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
    if (![payload isKindOfClass:[NSArray class]]) {
        return nil;
    }

    NSMutableArray<PFVIPERStudyTask *> *tasks = [NSMutableArray array];
    for (NSDictionary<NSString *, id> *item in (NSArray<NSDictionary<NSString *, id> *> *)payload) {
        [tasks addObject:[[PFVIPERStudyTask alloc] initWithTitle:item[@"title"] ?: @"untitled"
                                                           notes:item[@"notes"] ?: @""
                                                            tags:item[@"tags"] ?: @[]
                                                estimatedMinutes:[item[@"estimatedMinutes"] integerValue]
                                                           state:PFVIPERStateFromString(item[@"state"] ?: @"todo")]];
    }
    return [tasks copy];
}

@end
