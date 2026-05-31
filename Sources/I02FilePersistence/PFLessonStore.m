#import "PFLessonStore.h"

static NSString *PFLessonStoreTempPath(void) {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:@"pfocsd-lessons.json"];
}

@implementation PFLessonStore

- (NSArray<NSDictionary<NSString *, id> *> *)defaultLessons {
    return @[
        @{@"title": @"blocks", @"minutes": @20},
        @{@"title": @"KVO", @"minutes": @30}
    ];
}

- (nullable NSString *)saveLessons:(NSArray<NSDictionary<NSString *, id> *> *)lessons
                             error:(NSError **)error {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:lessons
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:error];
    if (jsonData == nil) {
        return nil;
    }

    NSString *path = PFLessonStoreTempPath();
    if (![jsonData writeToFile:path options:NSDataWritingAtomic error:error]) {
        return nil;
    }
    return path;
}

- (nullable NSArray<NSDictionary<NSString *, id> *> *)loadLessonsFromPath:(NSString *)path
                                                                     error:(NSError **)error {
    NSData *loadedData = [NSData dataWithContentsOfFile:path options:0 error:error];
    if (loadedData == nil) {
        return nil;
    }

    return [NSJSONSerialization JSONObjectWithData:loadedData options:0 error:error];
}

@end
