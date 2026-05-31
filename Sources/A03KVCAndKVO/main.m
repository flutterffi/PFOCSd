#import <Foundation/Foundation.h>
#import "PFProfile.h"

int main(void) {
    @autoreleasepool {
        NSDictionary<NSString *, id> *payload = @{
            @"name": @"Plato",
            @"streakDays": @12,
            @"focusTopics": [@[@"runtime", @"memory", @"concurrency"] mutableCopy]
        };

        PFProfile *profile = PFProfileFromDictionary(payload);
        PFProfileObserver *observer = [[PFProfileObserver alloc] init];

        [profile addObserver:observer
                  forKeyPath:@"streakDays"
                     options:NSKeyValueObservingOptionNew
                     context:nil];

        NSLog(@"profile name via KVC -> %@", [profile valueForKey:@"name"]);
        NSLog(@"first topic via key path -> %@", [profile valueForKeyPath:@"focusTopics.@firstObject"]);

        profile.streakDays = 13;
        [[profile mutableArrayValueForKey:@"focusTopics"] addObject:@"api design"];

        NSLog(@"topics after mutation -> %@", profile.focusTopics);

        [profile removeObserver:observer forKeyPath:@"streakDays"];

        // Practice idea: add a second observed property and compare KVC and direct mutation.
    }
    return 0;
}
