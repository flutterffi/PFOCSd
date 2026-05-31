#import "PFTaskPrinter.h"

@implementation PFTaskPrinter

- (NSString *)renderTask:(NSString *)task {
    return [NSString stringWithFormat:@"%@ %@", self.prefix, task];
}

- (NSString *)renderUppercaseTask:(NSString *)task {
    return [[self renderTask:task] uppercaseString];
}

@end

void PFPrintMethodAvailability(id target, SEL selector) {
    NSLog(@"%@ responds to %@ -> %@",
          NSStringFromClass([target class]),
          NSStringFromSelector(selector),
          [target respondsToSelector:selector] ? @"YES" : @"NO");
}
