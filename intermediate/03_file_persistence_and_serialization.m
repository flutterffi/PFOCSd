#import <Foundation/Foundation.h>

static NSString *makeTempPath(void) {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:@"pfocsd-lessons.json"];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray<NSDictionary<NSString *, id> *> *lessons = @[
            @{@"title": @"blocks", @"minutes": @20},
            @{@"title": @"KVO", @"minutes": @30}
        ];

        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:lessons options:NSJSONWritingPrettyPrinted error:&error];
        NSString *path = makeTempPath();

        [jsonData writeToFile:path options:NSDataWritingAtomic error:&error];
        NSData *loadedData = [NSData dataWithContentsOfFile:path options:0 error:&error];
        NSArray<NSDictionary<NSString *, id> *> *loadedLessons = [NSJSONSerialization JSONObjectWithData:loadedData options:0 error:&error];

        NSLog(@"path -> %@", path);
        NSLog(@"loaded lessons -> %@", loadedLessons);
        NSLog(@"error -> %@", error);
    }
    return 0;
}
