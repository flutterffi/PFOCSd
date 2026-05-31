#import <Foundation/Foundation.h>
#import "PFExercise.h"

int main(void) {
    @autoreleasepool {
        NSDictionary<NSString *, id> *payload = @{
            @"title": @"KVC model mapping",
            @"estimatedMinutes": @25,
            @"level": @"intermediate",
            @"notes": @"practice adding one more validation rule"
        };

        NSError *error = nil;
        PFExercise *exercise = [PFExercise exerciseFromDictionary:payload error:&error];
        NSLog(@"exercise -> %@", [exercise summary]);
        NSLog(@"error -> %@", error);

        // Practice idea: require one extra field and update the summary shape.
    }
    return 0;
}
