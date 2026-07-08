#import <Foundation/Foundation.h>

#import "PFImportCoordinator.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"A07OperationCancellation");

        PFImportCoordinator *coordinator = [[PFImportCoordinator alloc] init];
        [coordinator runScenario];

        NSLog(@"Exercise: add retry rules or promote cancellation to a shared token object.");
    }
    return 0;
}
