#import <Foundation/Foundation.h>
#import "PFForwardingFormatter.h"
#import "PFRenderInterceptor.h"

int main(void) {
    @autoreleasepool {
        PFTaskFormatter *formatter = [[PFTaskFormatter alloc] init];
        formatter.prefix = @"runtime:";

        NSLog(@"plain before swizzle -> %@", [formatter renderPlainTask:@"inspect method tables"]);

        [PFRenderInterceptor installLoggingInterceptorOnTaskFormatter];
        NSLog(@"plain after swizzle -> %@", [formatter renderPlainTask:@"inspect method tables"]);

        PFForwardingFormatter *forwarder = [[PFForwardingFormatter alloc] initWithFormatter:formatter];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSString *bullet = [forwarder performSelector:@selector(renderBulletTask:) withObject:@"trace fast forwarding"];
        NSString *markdown = [forwarder performSelector:@selector(renderMarkdownTask:) withObject:@"trace full forwarding"];
#pragma clang diagnostic pop

        NSLog(@"fast forwarding -> %@", bullet);
        NSLog(@"full forwarding -> %@", markdown);

        // Practice idea: replace the markdown branch with NSProxy and compare the forwarding path.
    }
    return 0;
}
