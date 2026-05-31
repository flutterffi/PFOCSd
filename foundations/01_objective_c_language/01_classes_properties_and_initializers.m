#import <Foundation/Foundation.h>

@interface PFStudyCard : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger difficulty;
- (instancetype)initWithTitle:(NSString *)title difficulty:(NSInteger)difficulty;
- (NSString *)summary;
@end

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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        PFStudyCard *card = [[PFStudyCard alloc] initWithTitle:@"properties and init"
                                                    difficulty:2];
        NSLog(@"%@", [card summary]);
    }
    return 0;
}
