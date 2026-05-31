#import <Foundation/Foundation.h>
#import "PFLessonStore.h"

int main(void) {
    @autoreleasepool {
        PFLessonStore *store = [[PFLessonStore alloc] init];
        NSError *error = nil;
        NSString *path = [store saveLessons:[store defaultLessons] error:&error];
        NSArray<NSDictionary<NSString *, id> *> *loadedLessons = path != nil
            ? [store loadLessonsFromPath:path error:&error]
            : nil;

        NSLog(@"path -> %@", path);
        NSLog(@"loaded lessons -> %@", loadedLessons);
        NSLog(@"error -> %@", error);

        // Practice idea: add a new field and keep the file format backward-compatible.
    }
    return 0;
}
