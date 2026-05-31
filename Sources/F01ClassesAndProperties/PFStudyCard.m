#import "PFStudyCard.h"

@implementation PFStudyCard

- (instancetype)initWithTitle:(NSString *)title difficulty:(NSInteger)difficulty {
    self = [super init];
    if (self) {
        _title = [title copy];
        _difficulty = difficulty;
    }
    return self;
}

- (NSString *)summary {
    return [NSString stringWithFormat:@"%@ (difficulty: %ld)", self.title, (long)self.difficulty];
}

@end
