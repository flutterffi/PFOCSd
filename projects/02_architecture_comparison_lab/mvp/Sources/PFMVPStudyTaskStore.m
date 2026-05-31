#import "PFMVPStudyTaskStore.h"

static NSString *PFMVPPlannerPath(void) {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:@"pfocsd-mvp-planner.json"];
}

static NSError *PFMVPSimulatedSaveError(void) {
    return [NSError errorWithDomain:@"PFOCSd.ArchitectureLab"
                               code:103
                           userInfo:@{NSLocalizedDescriptionKey: @"simulated disk write failure"}];
}

static PFMVPStudyTaskState PFMVPStateFromString(NSString *value) {
    if ([value isEqualToString:@"done"]) {
        return PFMVPStudyTaskStateDone;
    }
    if ([value isEqualToString:@"blocked"]) {
        return PFMVPStudyTaskStateBlocked;
    }
    return PFMVPStudyTaskStateTodo;
}

@implementation PFMVPStudyTaskStore {
    BOOL _shouldFailNextSave;
}

- (void)simulateNextSaveFailure {
    _shouldFailNextSave = YES;
}

- (NSArray<PFMVPStudyTask *> *)defaultTasks {
    return @[
        [[PFMVPStudyTask alloc] initWithTitle:@"Review ARC"
                                        notes:@"compare weak and copy"
                                         tags:@[@"memory", @"objc"]
                                     priority:2
                             estimatedMinutes:25
                                        state:PFMVPStudyTaskStateTodo],
        [[PFMVPStudyTask alloc] initWithTitle:@"Practice KVC"
                                        notes:@"map payload into model"
                                         tags:@[@"data-flow", @"kvc"]
                                     priority:4
                             estimatedMinutes:30
                                        state:PFMVPStudyTaskStateBlocked],
    ];
}

- (nullable NSString *)saveTasks:(NSArray<PFMVPStudyTask *> *)tasks error:(NSError **)error {
    if (_shouldFailNextSave) {
        _shouldFailNextSave = NO;
        if (error != NULL) {
            *error = PFMVPSimulatedSaveError();
        }
        return nil;
    }

    NSMutableArray<NSDictionary<NSString *, id> *> *payload = [NSMutableArray arrayWithCapacity:tasks.count];
    for (PFMVPStudyTask *task in tasks) {
        [payload addObject:[task dictionaryRepresentation]];
    }

    NSData *data = [NSJSONSerialization dataWithJSONObject:payload
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:error];
    if (data == nil) {
        return nil;
    }

    NSString *path = PFMVPPlannerPath();
    if (![data writeToFile:path options:NSDataWritingAtomic error:error]) {
        return nil;
    }
    return path;
}

- (nullable NSArray<PFMVPStudyTask *> *)loadTasksFromPath:(NSString *)path error:(NSError **)error {
    NSData *data = [NSData dataWithContentsOfFile:path options:0 error:error];
    if (data == nil) {
        return nil;
    }

    NSArray<NSDictionary<NSString *, id> *> *payload = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
    if (![payload isKindOfClass:[NSArray class]]) {
        return nil;
    }

    NSMutableArray<PFMVPStudyTask *> *tasks = [NSMutableArray arrayWithCapacity:payload.count];
    for (NSDictionary<NSString *, id> *item in payload) {
        [tasks addObject:[[PFMVPStudyTask alloc] initWithTitle:item[@"title"] ?: @"untitled"
                                                         notes:item[@"notes"] ?: @""
                                                          tags:item[@"tags"] ?: @[]
                                                      priority:[item[@"priority"] integerValue]
                                              estimatedMinutes:[item[@"estimatedMinutes"] integerValue]
                                                         state:PFMVPStateFromString(item[@"state"] ?: @"todo")]];
    }
    return tasks;
}

@end
