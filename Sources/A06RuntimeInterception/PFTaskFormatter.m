#import "PFTaskFormatter.h"

@implementation PFTaskFormatter

- (NSString *)renderPlainTask:(NSString *)task {
    return [NSString stringWithFormat:@"%@ %@", self.prefix, task];
}

- (NSString *)renderBulletTask:(NSString *)task {
    return [NSString stringWithFormat:@"- %@", [self renderPlainTask:task]];
}

@end
