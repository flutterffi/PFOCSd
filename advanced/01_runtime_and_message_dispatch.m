#import <Foundation/Foundation.h>
#import <objc/message.h>

@interface PFTaskPrinter : NSObject
@property (nonatomic, copy) NSString *prefix;
- (NSString *)renderTask:(NSString *)task;
- (NSString *)renderUppercaseTask:(NSString *)task;
@end

@implementation PFTaskPrinter

- (NSString *)renderTask:(NSString *)task {
    return [NSString stringWithFormat:@"%@ %@", self.prefix, task];
}

- (NSString *)renderUppercaseTask:(NSString *)task {
    return [[self renderTask:task] uppercaseString];
}

@end

static void printMethodAvailability(id target, SEL selector) {
    NSLog(@"%@ responds to %@ -> %@",
          NSStringFromClass([target class]),
          NSStringFromSelector(selector),
          [target respondsToSelector:selector] ? @"YES" : @"NO");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        PFTaskPrinter *printer = [[PFTaskPrinter alloc] init];
        printer.prefix = @"next:";

        SEL standardSelector = @selector(renderTask:);
        SEL uppercaseSelector = @selector(renderUppercaseTask:);
        SEL missingSelector = @selector(renderMarkdownTask:);

        printMethodAvailability(printer, standardSelector);
        printMethodAvailability(printer, uppercaseSelector);
        printMethodAvailability(printer, missingSelector);

        NSString *task = @"practice message dispatch";

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSString *dynamicResult = [printer performSelector:standardSelector withObject:task];
#pragma clang diagnostic pop

        typedef NSString *(*MsgSendFn)(id, SEL, NSString *);
        MsgSendFn send = (MsgSendFn)objc_msgSend;
        NSString *runtimeResult = send(printer, uppercaseSelector, task);

        NSLog(@"performSelector result: %@", dynamicResult);
        NSLog(@"objc_msgSend result: %@", runtimeResult);

        NSArray<NSString *> *selectorsToCompare = @[
            NSStringFromSelector(standardSelector),
            NSStringFromSelector(uppercaseSelector)
        ];

        for (NSString *selectorName in selectorsToCompare) {
            NSLog(@"selector token: %@", selectorName);
        }
    }
    return 0;
}
