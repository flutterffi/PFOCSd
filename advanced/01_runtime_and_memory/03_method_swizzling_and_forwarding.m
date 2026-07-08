#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface PFSwizzleLessonFormatter : NSObject
@property (nonatomic, copy) NSString *prefix;
- (NSString *)renderPlainTask:(NSString *)task;
@end

@implementation PFSwizzleLessonFormatter

- (NSString *)renderPlainTask:(NSString *)task {
    return [NSString stringWithFormat:@"%@ %@", self.prefix, task];
}

@end

@implementation PFSwizzleLessonFormatter (Logging)

- (NSString *)pf_logged_renderPlainTask:(NSString *)task {
    NSLog(@"[lesson swizzle] before -> %@", task);
    NSString *result = [self pf_logged_renderPlainTask:task];
    NSLog(@"[lesson swizzle] after -> %@", result);
    return result;
}

@end

@interface PFFullForwardingLesson : NSObject
@property (nonatomic, strong) PFSwizzleLessonFormatter *formatter;
- (instancetype)initWithFormatter:(PFSwizzleLessonFormatter *)formatter;
@end

@implementation PFFullForwardingLesson

- (instancetype)initWithFormatter:(PFSwizzleLessonFormatter *)formatter {
    self = [super init];
    if (self) {
        _formatter = formatter;
    }
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    if (selector == @selector(renderMarkdownTask:)) {
        return [self.formatter methodSignatureForSelector:@selector(renderPlainTask:)];
    }
    return [super methodSignatureForSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    if (invocation.selector == @selector(renderMarkdownTask:)) {
        NSString *task = nil;
        [invocation getArgument:&task atIndex:2];
        NSString *markdown = [NSString stringWithFormat:@"**%@**", [self.formatter renderPlainTask:task]];
        [invocation setReturnValue:&markdown];
        return;
    }
    [super forwardInvocation:invocation];
}

@end

static void PFInstallLessonSwizzle(void) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method original = class_getInstanceMethod([PFSwizzleLessonFormatter class], @selector(renderPlainTask:));
        Method replacement = class_getInstanceMethod([PFSwizzleLessonFormatter class], @selector(pf_logged_renderPlainTask:));
        method_exchangeImplementations(original, replacement);
    });
}

int main(void) {
    @autoreleasepool {
        PFSwizzleLessonFormatter *formatter = [[PFSwizzleLessonFormatter alloc] init];
        formatter.prefix = @"lesson:";

        NSLog(@"before swizzle -> %@", [formatter renderPlainTask:@"learn runtime interception"]);
        PFInstallLessonSwizzle();
        NSLog(@"after swizzle -> %@", [formatter renderPlainTask:@"learn runtime interception"]);

        PFFullForwardingLesson *forwarder = [[PFFullForwardingLesson alloc] initWithFormatter:formatter];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSString *markdown = [forwarder performSelector:@selector(renderMarkdownTask:) withObject:@"follow invocation forwarding"];
#pragma clang diagnostic pop

        NSLog(@"full forwarding -> %@", markdown);

        // Practice idea: add forwardingTargetForSelector: and compare it with forwardInvocation:.
    }
    return 0;
}
