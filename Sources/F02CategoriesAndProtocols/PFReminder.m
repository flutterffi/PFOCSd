#import "PFReminder.h"

@implementation PFReminder

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        _title = [title copy];
    }
    return self;
}

- (void)start {
    [self.delegate reminderDidFinishWithTitle:self.title];
}

@end
