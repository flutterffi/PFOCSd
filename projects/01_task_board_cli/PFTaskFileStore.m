#import "PFTaskFileStore.h"

static NSString * const PFTaskFileStoreErrorDomain = @"com.pfocsd.taskfilestore";

typedef NS_ENUM(NSInteger, PFTaskFileStoreErrorCode) {
    PFTaskFileStoreErrorCodeInvalidJSON = 1001,
    PFTaskFileStoreErrorCodeInvalidTask = 1002
};

@implementation PFTaskFileStore

- (NSArray<PFTask *> *)loadTasksFromFile:(NSString *)path error:(NSError **)error {
    NSData *data = [NSData dataWithContentsOfFile:path options:0 error:error];
    if (data == nil) {
        return nil;
    }

    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
    if (![object isKindOfClass:[NSArray class]]) {
        if (error != nil) {
            *error = [NSError errorWithDomain:PFTaskFileStoreErrorDomain
                                         code:PFTaskFileStoreErrorCodeInvalidJSON
                                     userInfo:@{NSLocalizedDescriptionKey: @"task file must contain a JSON array"}];
        }
        return nil;
    }

    NSMutableArray<PFTask *> *tasks = [NSMutableArray array];
    NSUInteger index = 0;

    for (id item in (NSArray *)object) {
        if (![item isKindOfClass:[NSDictionary class]]) {
            if (error != nil) {
                *error = [NSError errorWithDomain:PFTaskFileStoreErrorDomain
                                             code:PFTaskFileStoreErrorCodeInvalidTask
                                         userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"task at index %lu must be an object",
                                                                                (unsigned long)index]}];
            }
            return nil;
        }

        PFTask *task = [self taskFromDictionary:(NSDictionary<NSString *, id> *)item
                                          index:index
                                          error:error];
        if (task == nil) {
            return nil;
        }

        [tasks addObject:task];
        index += 1;
    }

    return [tasks copy];
}

- (BOOL)saveTasks:(NSArray<PFTask *> *)tasks toFile:(NSString *)path error:(NSError **)error {
    NSMutableArray<NSDictionary<NSString *, id> *> *payload = [NSMutableArray arrayWithCapacity:tasks.count];
    for (PFTask *task in tasks) {
        [payload addObject:[task dictionaryRepresentation]];
    }

    NSData *data = [NSJSONSerialization dataWithJSONObject:payload
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:error];
    if (data == nil) {
        return NO;
    }

    return [data writeToFile:path options:NSDataWritingAtomic error:error];
}

- (PFTask *)taskFromDictionary:(NSDictionary<NSString *, id> *)dictionary
                         index:(NSUInteger)index
                         error:(NSError **)error {
    NSString *title = dictionary[@"title"];
    NSArray<NSString *> *tags = dictionary[@"tags"];
    NSString *stateLabel = dictionary[@"state"];

    if (![title isKindOfClass:[NSString class]] || title.length == 0) {
        if (error != nil) {
            *error = [NSError errorWithDomain:PFTaskFileStoreErrorDomain
                                         code:PFTaskFileStoreErrorCodeInvalidTask
                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"task at index %lu must include a non-empty title",
                                                                            (unsigned long)index]}];
        }
        return nil;
    }

    if (![tags isKindOfClass:[NSArray class]]) {
        if (error != nil) {
            *error = [NSError errorWithDomain:PFTaskFileStoreErrorDomain
                                         code:PFTaskFileStoreErrorCodeInvalidTask
                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"task at index %lu must include a tags array",
                                                                            (unsigned long)index]}];
        }
        return nil;
    }

    NSMutableArray<NSString *> *cleanTags = [NSMutableArray arrayWithCapacity:tags.count];
    for (id tag in tags) {
        if (![tag isKindOfClass:[NSString class]]) {
            if (error != nil) {
                *error = [NSError errorWithDomain:PFTaskFileStoreErrorDomain
                                             code:PFTaskFileStoreErrorCodeInvalidTask
                                         userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"task at index %lu contains a non-string tag",
                                                                                (unsigned long)index]}];
            }
            return nil;
        }
        [cleanTags addObject:tag];
    }

    if (![stateLabel isKindOfClass:[NSString class]]) {
        if (error != nil) {
            *error = [NSError errorWithDomain:PFTaskFileStoreErrorDomain
                                         code:PFTaskFileStoreErrorCodeInvalidTask
                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"task at index %lu must include a state string",
                                                                            (unsigned long)index]}];
        }
        return nil;
    }

    NSNumber *stateNumber = PFTaskStateNumberFromLabel(stateLabel);
    if (stateNumber == nil) {
        if (error != nil) {
            *error = [NSError errorWithDomain:PFTaskFileStoreErrorDomain
                                         code:PFTaskFileStoreErrorCodeInvalidTask
                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"task at index %lu uses unsupported state '%@'",
                                                                            (unsigned long)index,
                                                                            stateLabel]}];
        }
        return nil;
    }

    return [[PFTask alloc] initWithTitle:title
                                    tags:[cleanTags copy]
                                   state:stateNumber.integerValue];
}

@end
