#import "PFRenderInterceptor.h"
#import "PFTaskFormatter.h"
#import <objc/runtime.h>

@implementation PFRenderInterceptor

+ (void)installLoggingInterceptorOnTaskFormatter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [PFTaskFormatter class];
        SEL originalSelector = @selector(renderPlainTask:);
        SEL swizzledSelector = @selector(pf_logged_renderPlainTask:);

        Method originalMethod = class_getInstanceMethod(cls, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

@end

@implementation PFTaskFormatter (PFRenderInterceptor)

- (NSString *)pf_logged_renderPlainTask:(NSString *)task {
    NSLog(@"[swizzle] before render -> %@", task);
    NSString *result = [self pf_logged_renderPlainTask:task];
    NSLog(@"[swizzle] after render -> %@", result);
    return result;
}

@end
