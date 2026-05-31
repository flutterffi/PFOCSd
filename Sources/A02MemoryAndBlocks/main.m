#import <Foundation/Foundation.h>
#import "PFTaskStore.h"

int main(void) {
    @autoreleasepool {
        PFTaskStore *store = PFMakeTaskStore();

        NSMutableString *mutableInput = [NSMutableString stringWithString:@"draft title"];
        store.name = mutableInput;
        [mutableInput appendString:@" changed outside"];

        NSLog(@"copied property keeps value stable -> %@", store.name);

        __weak PFTaskStore *weakStore = store;
        store.changeHandler = ^(NSString *message) {
            NSLog(@"%@", message);
            NSLog(@"weak reference available -> %@", weakStore.name);
        };

        [store addTask:@"practice ARC rules"];
        [store addTask:@"review block capture"];

        NSString *(^formatter)(NSString *) = ^NSString *(NSString *task) {
            return [NSString stringWithFormat:@"[%@] %@", store.name, task];
        };

        NSLog(@"%@", formatter(@"check retain-cycle patterns"));

        // Practice idea: create and then remove a retain cycle.
    }
    return 0;
}
