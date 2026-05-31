#import <Foundation/Foundation.h>

@interface NSString (PFStudyFormatting)
- (NSString *)pf_titleCaseLabel;
@end

@implementation NSString (PFStudyFormatting)

- (NSString *)pf_titleCaseLabel {
    return [self capitalizedString];
}

@end

static NSArray<NSString *> *sortedTopics(NSArray<NSString *> *topics) {
    return [topics sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray<NSString *> *topics = @[@"blocks", @"protocols", @"categories"];
        NSArray<NSString *> *sorted = sortedTopics(topics);

        for (NSString *topic in sorted) {
            NSLog(@"%@", [topic pf_titleCaseLabel]);
        }
    }
    return 0;
}
