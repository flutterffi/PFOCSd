#import <Foundation/Foundation.h>
#import "PFTopicLibrary.h"

int main(void) {
    @autoreleasepool {
        PFTopicLibrary *library = [[PFTopicLibrary alloc] init];
        NSArray<NSString *> *topics = [library topics];
        NSDictionary<NSString *, NSString *> *goalByTopic = [library goalByTopic];

        NSLog(@"first topic -> %@", topics.firstObject);
        for (NSString *topic in topics) {
            NSLog(@"%@ -> %@", topic, goalByTopic[topic]);
        }
    }
    return 0;
}
