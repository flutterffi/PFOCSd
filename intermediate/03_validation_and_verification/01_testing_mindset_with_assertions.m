#import <Foundation/Foundation.h>

static NSInteger weightedScore(NSInteger difficulty, NSInteger tagsCount) {
    return difficulty * 2 + tagsCount;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSInteger score = weightedScore(3, 2);
        NSCAssert(score == 8, @"expected weighted score to be 8");

        NSArray<NSNumber *> *scores = @[@(weightedScore(1, 1)),
                                        @(weightedScore(2, 0)),
                                        @(weightedScore(3, 2))];

        NSLog(@"assertions passed, scores -> %@", scores);
    }
    return 0;
}
