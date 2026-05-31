#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "PFTaskPrinter.h"

int main(void) {
    @autoreleasepool {
        PFTaskPrinter *printer = [[PFTaskPrinter alloc] init];
        printer.prefix = @"next:";

        SEL standardSelector = @selector(renderTask:);
        SEL uppercaseSelector = @selector(renderUppercaseTask:);
        SEL missingSelector = @selector(renderMarkdownTask:);

        PFPrintMethodAvailability(printer, standardSelector);
        PFPrintMethodAvailability(printer, uppercaseSelector);
        PFPrintMethodAvailability(printer, missingSelector);

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

        // Practice idea: add one more selector and compare the dispatch path.
    }
    return 0;
}
