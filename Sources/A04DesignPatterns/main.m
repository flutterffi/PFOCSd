#import <Foundation/Foundation.h>
#import "PFTaskService.h"

int main(void) {
    @autoreleasepool {
        PFTaskService *service = [[PFTaskService alloc] initWithScorer:[[PFWeightedScorer alloc] init]];
        NSDictionary<NSString *, id> *summary = [service summaryForTask:@"  design a safer API boundary  "
                                                                   tags:@[@"objc", @"protocol", @"review"]];

        NSLog(@"task summary -> %@", summary);

        // Practice idea: add a second scorer strategy and swap implementations.
    }
    return 0;
}
