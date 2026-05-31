#import <Foundation/Foundation.h>
#import "PFScoreCalculator.h"

int main(void) {
    @autoreleasepool {
        PFScoreCalculator *calculator = [[PFScoreCalculator alloc] init];
        NSInteger score = [calculator weightedScoreWithDifficulty:3 tagsCount:2];
        NSCAssert(score == 8, @"expected weighted score to be 8");

        NSArray<NSNumber *> *scores = @[
            @([calculator weightedScoreWithDifficulty:1 tagsCount:1]),
            @([calculator weightedScoreWithDifficulty:2 tagsCount:0]),
            @([calculator weightedScoreWithDifficulty:3 tagsCount:2])
        ];

        NSLog(@"assertions passed, scores -> %@", scores);

        // Practice idea: add one edge-case assertion before changing the formula.
    }
    return 0;
}
