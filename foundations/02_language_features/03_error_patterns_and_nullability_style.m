#import <Foundation/Foundation.h>

static NSNumber *parsePositiveScore(NSString *value, NSError **error) {
    NSInteger score = value.integerValue;
    if (score <= 0) {
        if (error != nil) {
            *error = [NSError errorWithDomain:@"com.pfocsd.validation"
                                         code:1001
                                     userInfo:@{NSLocalizedDescriptionKey: @"score must be positive"}];
        }
        return nil;
    }
    return @(score);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSError *error = nil;
        NSNumber *score = parsePositiveScore(@"8", &error);
        NSLog(@"score -> %@", score);

        NSNumber *badScore = parsePositiveScore(@"0", &error);
        NSLog(@"bad score -> %@", badScore);
        NSLog(@"error -> %@", error.localizedDescription);
    }
    return 0;
}
