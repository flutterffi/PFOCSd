#import "PFTopicLibrary.h"

@implementation PFTopicLibrary

- (NSArray<NSString *> *)topics {
    return @[@"NSString", @"NSArray", @"NSDictionary"];
}

- (NSDictionary<NSString *, NSString *> *)goalByTopic {
    return @{
        @"NSString": @"format output",
        @"NSArray": @"store ordered data",
        @"NSDictionary": @"map keys to values",
    };
}

@end
