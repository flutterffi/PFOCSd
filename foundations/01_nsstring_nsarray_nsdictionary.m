#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *learner = @"Plato";
        NSArray<NSString *> *topics = @[@"NSString", @"NSArray", @"NSDictionary"];
        NSDictionary<NSString *, NSString *> *goalByTopic = @{
            @"NSString": @"format output",
            @"NSArray": @"store ordered data",
            @"NSDictionary": @"map keys to values"
        };

        NSLog(@"learner -> %@", learner);
        NSLog(@"first topic -> %@", topics.firstObject);

        for (NSString *topic in topics) {
            NSLog(@"%@ -> %@", topic, goalByTopic[topic]);
        }

        NSString *summary = [NSString stringWithFormat:@"%@ is reviewing %lu Foundation collections",
                             learner,
                             (unsigned long)topics.count];
        NSLog(@"%@", summary);
    }
    return 0;
}
