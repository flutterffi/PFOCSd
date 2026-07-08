#import "PFForwardingFormatter.h"

@interface PFForwardingFormatter ()
@property (nonatomic, strong) PFTaskFormatter *formatter;
@end

@implementation PFForwardingFormatter

- (instancetype)initWithFormatter:(PFTaskFormatter *)formatter {
    self = [super init];
    if (self) {
        _formatter = formatter;
    }
    return self;
}

- (id)forwardingTargetForSelector:(SEL)selector {
    if (selector == @selector(renderBulletTask:)) {
        return self.formatter;
    }
    return [super forwardingTargetForSelector:selector];
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
